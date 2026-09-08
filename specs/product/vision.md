# Soonio Product Vision

## Purpose and Audience

Soonio là web app + PWA và Chrome extension giúp người dùng theo dõi subscription renewal, trial expiration, domain/SSL expiry, API token/credential rotation, warranty, contract và deadline khác. UI phù hợp phần lớn người dùng, không yêu cầu kiến thức kỹ thuật.

Người dùng cần biết: cái gì sắp đến hạn, cái gì sắp tốn tiền, và cần hành động gì trước deadline.

## Core Flow

1. Thêm tracked item từ web hoặc Chrome extension.
2. Ghi due/renewal/expiry date, amount nếu có và reminder schedule.
3. Xem upcoming items và những việc cần chú ý trước.
4. Nhận email reminder trước deadline theo policy hiệu lực do backend xử lý.
5. Hành động trước hạn và cập nhật item khi cần.

Chrome quick capture ưu tiên mở website → click extension → prefill title/domain/url → nhập date/price → save qua API.

## MVP

- Authentication và dữ liệu cá nhân được phân quyền theo user.
- Tracked item CRUD, detail/edit, search/filter/sort và All Items.
- Dashboard / Upcoming với summary nhẹ.
- Group tùy chỉnh, một cấp, optional; item thuộc tối đa một group.
- Email reminders và Notification Settings global + per-item override.
- Chrome quick capture; web và PWA dùng cùng information architecture.

## Product Principles

- Ưu tiên thông tin cần hành động hơn analytics; không làm dashboard nhiều chart hoặc giống enterprise admin.
- Mobile-first, ít bước, mỗi màn hình có primary action rõ ràng.
- Progressive disclosure cho field nâng cao; không ép tổ chức dữ liệu sớm.
- Reminder có default hợp lý; chỉ mở cấu hình riêng khi người dùng cần override.
- Clarity quan trọng hơn density; accessibility và keyboard navigation là yêu cầu xuyên suốt.
- Laravel là source of truth; client không quyết định business logic quan trọng.

## Boundaries and Open Decisions

Không đưa AI extraction, microservices, Kafka, Kubernetes hoặc kiến trúc phức tạp vào MVP. Notification MVP chỉ có email; Web Push và Telegram là hướng mở rộng.

Recurrence, quy đổi/tổng hợp tiền tệ, tiêu chí Needs attention, ngày quá hạn, xóa group, auth flow và offline PWA cần được chốt trong feature spec trước implementation liên quan. Theo dõi credential rotation không mặc nhiên bao gồm lưu secret.

## Success Direction

Người dùng có thể thêm item nhanh, nhận ra việc cần làm tiếp theo và tin rằng reminder phản ánh đúng cấu hình hiện tại của mình.

## Related Documents

- [Glossary](glossary.md)
- [UI guidelines](../design/ui-guidelines.md)
- [System overview](../architecture/system-overview.md)
