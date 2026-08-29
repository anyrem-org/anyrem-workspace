# Notes

## Goal

Cho phép người dùng lưu và tiếp tục sử dụng kiến thức cá nhân dưới dạng note rich text.

## Scope

- `anyrem-desktop`: tạo, đọc, chỉnh sửa, xoá, liệt kê và pin note bằng BlockNote/Tiptap data.
- `anyrem-be`: note persistence, user scoping, soft delete, category/related-note validation và search indexing.

## Behavior

- Note có title, rich-text content, category optional, related note optional và trạng thái pinned.
- Người dùng chỉ đọc hoặc thay đổi note của chính họ.
- Note list hỗ trợ pagination, query và category filter.
- Pin/unpin thay đổi trạng thái ưu tiên của note.
- Xoá note qua `DELETE /notes/:id` thực hiện soft delete (`deletedAt`), gỡ khỏi search index và đánh dấu ảnh đính kèm của note là đã xoá. Note đã xoá không còn xuất hiện trong list, search hoặc detail.
- Desktop yêu cầu xác nhận trước khi xoá. Nút xoá đặt trong danger zone ở cuối panel metadata, không đặt cạnh thao tác chính như Save hoặc Pin:
  - Note editor: cuối sidebar `Note details`.
  - Note detail modal: cuối sidebar related content.
  - Search preview: footer dưới `Open full memory`.

## Acceptance Criteria

- Tạo hoặc sửa note được lưu và hiển thị lại đúng nội dung.
- Category và related note không hợp lệ bị backend từ chối.
- Pin state tồn tại sau khi tải lại dữ liệu.
- Xoá note sau khi xác nhận làm note biến mất khỏi editor, modal, search preview và các list liên quan.
- Gọi lại `GET /notes/:id` cho note đã xoá trả `404`.
