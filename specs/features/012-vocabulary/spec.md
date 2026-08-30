# Vocabulary (MCP Templates)

## Goal

Hỗ trợ user học tiếng Anh qua ChatGPT, Copilot hoặc client MCP khác: lưu từ vựng đã học thành note trong AnyRem. Mỗi từ vựng tương ứng một note. MCP phải tuân theo template do backend định nghĩa. Không lưu từ đã tồn tại và báo lại cho user.

## Scope

- `anyrem-be`: registry template note, MCP API bulk-create, convert markdown → BlockNote, dedupe theo title, tái sử dụng `NotesService.create()` (search index, activity).
- `anyrem-mcp`: tools `anyrem_get_templates`, `anyrem_bulk_create_from_template`.
- `anyrem-desktop`: không có UI riêng; note tạo qua MCP hiển thị như note thường.

## Behavior

### Template registry

- Backend giữ danh sách template trong `notes.templates.ts`.
- Mỗi template có `id`, `name`, `schema` (chuỗi hướng dẫn cho AI) và logic build nội dung note.
- Template mới thêm bằng cách đăng ký entry mới trong registry; MCP đọc schema qua API, không hardcode từng template trong tool description.
- Template mặc định: `vocabulary` (`DEFAULT_NOTE_TEMPLATE_ID`).

### Template `vocabulary`

- Một record = một từ tiếng Anh = một note.
- `title`: chỉ chứa từ/cụm từ (ví dụ `compromise`), tối đa 300 ký tự.
- `content`: markdown **không** lặp title, **không** dùng H1. Các section H2 theo thứ tự:
  - `## Meaning`
  - `## Pronunciation`
  - `## Type`
  - `## Example`
  - `## Easy to remember`
  - `## Topic`
- Backend prepend H1 từ `title`, parse phần còn lại bằng BlockNote markdown → `contentJson`.

### Duplicate handling

- So sánh title đã normalize (trim + lowercase, case-insensitive với DB) trong phạm vi user.
- Title đã có note (chưa xoá) → skip, `reason: already_exists`.
- Trùng title trong cùng request → skip, `reason: duplicate_in_request`.
- MCP/AI phải đọc `skipped` và cảnh báo user.

### Bulk create side effects

- Mỗi note tạo qua `NotesService.create()`: activity `CREATED`, search index, upload image sync nếu có.
- Giới hạn: tối đa 50 record/request; `content` tối đa 10_000 ký tự.

### MCP workflow

1. `anyrem_get_templates` → lấy `templates[].id`, `name`, `schema`.
2. AI build `records[]` theo `schema` của template chọn.
3. `anyrem_bulk_create_from_template` với `templateId` (optional, mặc định `vocabulary`) và `records`.
4. Đọc `created`, `skipped`, `summary` để báo kết quả.

## API (MCP, `McpGuard`)

| Method | Path | Mô tả |
|--------|------|--------|
| `GET` | `/api/mcp/notes/templates` | Danh sách template `{ templates: [{ id, name, schema }] }` |
| `POST` | `/api/mcp/notes/templates/bulk-create-from-template` | Bulk tạo note từ template |

### Request body — bulk create

```json
{
  "templateId": "vocabulary",
  "records": [
    {
      "title": "compromise",
      "content": "## Meaning\nThỏa hiệp\n\n## Pronunciation\n/ˈkɒmprəmaɪz/\n..."
    }
  ]
}
```

- `templateId` optional; bỏ qua → dùng template mặc định.
- `templateId` không tồn tại → `400 Bad Request`.

### Response — bulk create

```json
{
  "templateId": "vocabulary",
  "created": [{ "id": "uuid", "title": "compromise" }],
  "skipped": [{ "title": "compromise", "reason": "already_exists" }],
  "summary": "Created 1, skipped 1."
}
```

- `reason`: `already_exists` | `duplicate_in_request`.

## MCP tools (`anyrem-mcp`)

| Tool | Mô tả |
|------|--------|
| `anyrem_get_templates` | Gọi `GET /api/mcp/notes/templates` |
| `anyrem_bulk_create_from_template` | Gọi bulk-create API; input `templateId?`, `records[]` |

Tool descriptions template-agnostic: luôn tham chiếu schema từ `anyrem_get_templates`, không hardcode section vocabulary trong mô tả tool.

## Acceptance Criteria

- `GET /api/mcp/notes/templates` trả ít nhất template `vocabulary` với `schema` mô tả đủ các section H2.
- Bulk create record hợp lệ tạo note với H1 = `title` và body đúng markdown sections.
- Gọi lại với cùng `title` (khác hoa/thường) → `skipped` với `already_exists`, không tạo note trùng.
- Request có hai record cùng title → một `created`, một `duplicate_in_request`.
- Note tạo qua MCP tìm được trong global search sau index.
- Activity feed có event tạo note cho mỗi note `created`.
- `templateId` sai → `400`.
- Request > 50 records hoặc field vượt max length → validation error.
