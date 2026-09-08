# Soonio System Overview

## Getting Started

1. Đọc feature specification liên quan trong danh sách bên dưới.
2. Đọc [ADR guide](../decisions/README.md), [Soonio ADR](../decisions/0002-soonio-architecture-and-ownership.md) và [coding conventions](../engineering/coding-conventions.md).
3. Đọc hướng dẫn cục bộ trong repository owner trước khi sửa code; với UI, đọc [UI guidelines](../design/ui-guidelines.md).

## Repository Ownership

| Repository | Ownership |
| --- | --- |
| `repos/soonio-api` | Laravel REST API, dữ liệu, validation, authorization, business logic, xác định và gửi reminders, API contract. |
| `repos/soonio-web` | React SPA + PWA, routing, forms, server-state cache và trải nghiệm responsive. |
| `repos/soonio-extension` | WXT + React Chrome extension, tab metadata, quick capture và tích hợp API. |
| `repos/soonio-shared` | Components, primitives, theme và public exports cho UI dùng chung. |

Đây là ownership mục tiêu. Xem [setup status](../../README.md#setup-status) trước khi dùng bootstrap hoặc cấu hình IDE hiện có.

## Source of Truth and Data Flow

Workspace sở hữu product behavior, UI guidelines, feature specifications và architecture decisions. Repository code sở hữu implementation, technical documentation và kiểm tra cục bộ. Không sao chép contract/spec sang nhiều nơi; liên kết đến owner.

Web/extension → Laravel REST API → dữ liệu của user. Laravel xác thực, phân quyền, validate và xử lý business logic. Laravel xử lý reminder từ settings và item hiện tại, rồi gửi qua email. Shared UI cung cấp presentation cho client, không truy cập dữ liệu hoặc platform API trực tiếp.

API contract thuộc backend: [REST API v1](../../repos/soonio-api/docs/api.md), theo [ADR 0004](../decisions/0004-api-auth-and-persistence.md). Công cụ OpenAPI chưa chốt. Không dùng microservices ở giai đoạn này.

## MVP Specifications

- [001 Authentication](../features/001-authentication/spec.md)
- [002 Tracked items](../features/002-tracked-items/spec.md)
- [003 Dashboard / Upcoming](../features/003-dashboard-upcoming/spec.md)
- [004 Groups](../features/004-groups/spec.md)
- [005 Reminders](../features/005-reminders/spec.md)
- [006 Notification Settings](../features/006-notification-settings/spec.md)
- [007 Chrome quick capture](../features/007-chrome-quick-capture/spec.md)

Các spec ở trạng thái draft. Behavior đã chốt được ghi riêng với acceptance dự thảo và câu hỏi còn mở; không tự chọn câu trả lời cho các quyết định chưa được chốt khi implementation phụ thuộc chúng.

## Feature Flow and Maintenance

1. Feature mới có folder chứa `spec.md` và `status.md`; ghi goal, scope, behavior, acceptance và open questions.
2. Chốt các quyết định ảnh hưởng phần sắp triển khai. Thay đổi API bắt đầu ở backend/contract, sau đó cập nhật consumer liên quan.
3. Chỉ sửa repository owner trong phạm vi; shared chỉ tham gia khi có UI tái sử dụng thực tế.
4. Chạy kiểm tra phù hợp, cập nhật status và acceptance theo bằng chứng.

Status dùng `draft`, `in-progress`, `implemented`, `verified`, `blocked`. Status file có Last Reviewed, progress theo repository và acceptance state. Không đánh dấu implemented/verified vì tài liệu đã hoàn tất.

Cải tiến cùng goal giữ cùng feature; user value độc lập tạo feature mới. Refactor không đổi behavior không cần sửa spec. Thay đổi kiến trúc/ownership cần ADR; không sửa accepted ADR để viết lại quyết định cũ. Agent tự cập nhật fact đã xác minh trong scope đã chốt; khi behavior còn mâu thuẫn hoặc thiếu quyết định, làm rõ trước phần implementation phụ thuộc nó.

## Bug Handling

Bug là implementation không khớp behavior đã chốt. Bug cục bộ xử lý tại repository owner; bug xuyên repository/API hoặc expected behavior chưa rõ ghi trong `specs/bugs/BUG-<id>-<slug>.md` khi phát sinh. Bug note gồm Status, Reported, Fixed, Feature, expected/actual behavior, scope và regression criteria; Fixed là `—` đến khi xác nhận. Không sửa spec để hợp thức hóa bug.

## Related Documents

- [Vision](../product/vision.md) và [glossary](../product/glossary.md)
- [API conventions](../api/conventions.md)
- [UI guidelines](../design/ui-guidelines.md)
