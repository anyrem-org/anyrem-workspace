# AnyRem System Map

## Getting Started

1. Đọc feature specification trong `specs/features/` nếu đã tồn tại.
2. Đọc `specs/decisions/README.md` và ADR liên quan trước khi thay đổi kiến trúc, xác thực, API contract hoặc nhiều repository.
3. Mở repository owner dưới `repos/` và đọc hướng dẫn cục bộ trước khi sửa code.

## Repository Ownership

| Repository | Ownership | Read When |
| --- | --- | --- |
| `repos/anyrem-desktop` | UI Electron desktop, preload/main process, renderer và tích hợp API cho desktop | Thay đổi hành vi desktop hoặc tích hợp API vào ứng dụng |
| `repos/anyrem-be` | NestJS HTTP API, database, search indexing, jobs và OpenAPI contract được generate | Thay đổi business behavior, dữ liệu, quyền hoặc HTTP endpoint |
| `repos/anyrem-mcp` | MCP server, tools và tích hợp API cho AI client | Thêm hoặc thay đổi MCP capability |
| `repos/anyrem-infra` | Keycloak và cấu hình deployment/runtime | Thay đổi identity provider hoặc hạ tầng |

## Source of Truth

- Product behavior, feature specification xuyên repository và architecture decision: workspace này dưới `specs/`.
- HTTP API contract: `anyrem-be`; OpenAPI được backend generate và không được sửa tay tại repository khác.
- Chi tiết implementation kỹ thuật và hướng dẫn chạy/test cục bộ: repository sở hữu code.

Không sao chép specification hoặc API contract sang nơi khác. Hãy liên kết đến owner của chúng.

## Feature Flow

1. Với feature mới, tạo `specs/features/<id>-<name>/` chứa cả `spec.md` và `status.md`.
2. Viết `spec.md` với goal, scope, behavior và acceptance criteria. Khởi tạo `status.md` với `Status`, `Last Reviewed`, progress theo repository và acceptance state.
3. Nếu feature thay đổi HTTP API, implement tại `anyrem-be` trước rồi generate lại OpenAPI.
4. Cập nhật consumer cần thiết: `anyrem-desktop` và/hoặc `anyrem-mcp`.
5. Chạy acceptance check theo feature specification và cập nhật `status.md`.

`Status` dùng một trong các giá trị `draft`, `in-progress`, `implemented`, `verified` hoặc `blocked`. Agent cập nhật status sau mỗi thay đổi đã được xác minh trong scope; con người chốt behavior mới hoặc acceptance criteria trước khi implementation tiếp tục.

Với thay đổi chỉ thuộc desktop, làm việc tại `anyrem-desktop`; backend và MCP ngoài scope trừ khi feature specification nêu khác đi.

## Feature Changes

- Cải tiến vẫn phục vụ goal hiện có được thực hiện trong cùng folder feature; không tạo feature ID mới.
- Nếu behavior hoặc acceptance criteria đổi, agent draft thay đổi `spec.md` trước; con người chốt khi có trade-off hoặc behavior chưa rõ.
- Refactor hoặc chỉnh UI không đổi behavior chỉ cần sửa code và validation phù hợp; không cần sửa `spec.md`.
- Thay đổi API theo thứ tự feature specification, backend/OpenAPI, consumer và `status.md`. Thay đổi kiến trúc hoặc ownership cần ADR mới.
- User value độc lập ngoài goal hiện có tạo feature ID mới. Code không khớp spec là bug và theo `Bug Handling`.
- Sau implementation, cập nhật `status.md` theo `in-progress`, `implemented` và `verified` khi acceptance đã được kiểm chứng.

## Bug Handling

- Bug là hành vi thực tế không khớp với feature specification hoặc acceptance criteria đã chốt.
- Bug cục bộ được theo dõi, sửa và test tại repository owner; không cần tạo tài liệu workspace.
- Bug chạm nhiều repository, API contract hoặc có expected behavior chưa rõ được ghi tại `specs/bugs/BUG-<id>-<slug>.md`. Tạo folder `specs/bugs/` khi có bug đầu tiên.
- Bug note gồm `Status`, `Reported`, `Fixed`, `Feature`, expected behavior, actual behavior, scope và regression criteria. `Fixed` dùng `—` cho đến khi được xác nhận.
- Không sửa feature specification để hợp thức hoá bug. Nếu product muốn hành vi mới, cập nhật feature specification trước và xử lý như feature change.

## Documentation Maintenance

- Agent tự cập nhật tài liệu khi fact đã được xác minh và nằm trong scope đã chốt, ví dụ feature status, bug `Fixed` date, OpenAPI sau khi backend đổi contract hoặc README khi setup thay đổi rõ ràng.
- Con người phải chốt trước khi cập nhật product behavior chưa rõ, acceptance criteria, breaking API change, product vision/scope, roadmap hoặc architecture decision có trade-off.
- Khi spec, ADR và code mâu thuẫn hoặc không đủ để quyết định, agent dừng implementation và yêu cầu con người xác nhận thay vì tự chọn behavior mới.

## Related Workspace Documents

- `specs/product/vision.md`: mục đích và phạm vi sản phẩm.
- `specs/product/glossary.md`: domain term dùng chung.
- `specs/api/conventions.md`: quy tắc áp dụng cho toàn bộ API.
- `specs/engineering/coding-conventions.md`: convention dùng chung cho các code repository.
- `specs/decisions/README.md`: mục đích, lifecycle và format của architecture decision.
