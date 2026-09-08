# 0002 — Soonio Architecture and Ownership

Status: accepted

Date: 2026-09-05

## Context

Soonio theo dõi deadlines, renewals và expirations qua web/PWA và Chrome extension. User đã chốt kiến trúc, stack và ownership trong kế hoạch chuẩn hóa tài liệu. ADR này ghi nhận quyết định đó; không xác nhận implementation đã hoàn tất. ADR sản phẩm cũ được xóa theo yêu cầu và còn trong Git history.

## Decision

- Giữ các repository độc lập dưới `repos/`: `soonio-api`, `soonio-web`, `soonio-extension`, `soonio-shared`.
- Laravel REST API là source of truth cho dữ liệu, validation, authorization, business logic và reminders; không dùng microservices giai đoạn này.
- Web là React SPA + PWA; extension là WXT + React. Cả hai là client của backend.
- Shared sở hữu components/primitives/theme tái sử dụng dựa trên Mantine, không chứa phụ thuộc riêng client/platform. Client chỉ dùng public exports; shared không import ngược.
- Workspace sở hữu product/UI specifications, conventions và ADR; repository code sở hữu implementation, technical docs và tests.
- API contract thuộc backend. Tooling OpenAPI và wire format sẽ được chốt trước implementation liên quan.

Frontend stack và cấu trúc feature theo [coding conventions](../engineering/coding-conventions.md). Notification policy đã chốt nằm tại [feature owner](../features/006-notification-settings/spec.md).

## Consequences

Business behavior nhất quán giữa web và extension. Shared UI giúp tái sử dụng presentation nhưng cần chốt cách phân phối/version khi tích hợp. Thay đổi API bắt đầu ở backend rồi tới consumer. Mỗi repository giữ Git history và phát hành riêng; workspace không sao chép contract.

Setup scripts/IDE chưa phản ánh đủ bốn repository; xem [setup status](../../README.md#setup-status). Auth flow, reminder scheduling details và offline PWA không được quyết định bởi ADR này.

## Alternatives Considered

- Microservices và hạ tầng phức tạp: ngoài nhu cầu MVP đã chốt.
- Business logic trong client: không đáp ứng yêu cầu Laravel là source of truth.
- Sao chép UI dùng chung giữa client: thay bằng repository shared theo yêu cầu user.
- Shared phụ thuộc router/store/platform: làm giảm khả năng tái sử dụng, không chọn.
