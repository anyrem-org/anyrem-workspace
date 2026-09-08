# Reminders

Status: in-progress

Behavior đã chốt và câu hỏi còn mở được phân biệt bên dưới. Acceptance criteria là dự thảo, chưa phải bằng chứng implementation.

## Goal

Gửi email giúp user hành động trước deadline theo reminder policy hiệu lực.

## Scope and Ownership

Laravel sở hữu tính lịch hiệu lực, điều kiện gửi và thực hiện delivery. Web/extension hiển thị cấu hình và gửi lựa chọn qua API; không chạy reminder scheduler làm source of truth. Notification policy có nguồn duy nhất tại [Notification Settings](../006-notification-settings/spec.md).

## Confirmed Behavior

- MVP gửi qua email; Web Push và Telegram ngoài scope hiện tại.
- Backend áp dụng policy Default/Custom/Disabled và global Email switch của feature owner.
- Deadline và settings hiện tại phải là căn cứ của behavior gửi; không đóng băng global schedule vào item Default lúc tạo.
- Không chỉ dựa vào việc web/PWA/extension đang mở để thực hiện reminder phía server.

## Acceptance Criteria — Draft

- Mốc đến lượt gửi theo lịch hiệu lực tạo email cho đúng user/item theo contract được chốt.
- Default phản ánh global schedule mới; Custom giữ lịch riêng; Disabled không gửi.
- Email Off chặn mọi email reminder, kể cả Custom; giữ cấu hình lịch.
- Reset to default làm các lần nhắc tương lai tuân theo global schedule hiện tại.
- Kiểm chứng trường hợp đổi settings/deadline sát thời điểm gửi sau khi quy tắc xử lý pending jobs được chốt.
- Lỗi delivery được kiểm chứng cùng retry/duplicate behavior khi chính sách đó được chốt; không đánh dấu đã gửi thành công nếu gửi lỗi.

## Open Questions Before Implementation

- Email default On/Off, địa chỉ nhận, verification requirement, provider/template và nội dung/action link?
- Giờ gửi, timezone, daylight-saving, on-due-date và giới hạn custom offsets/units?
- Khi bật lại email, đổi schedule/deadline, chuyển mode hoặc xóa item: xử lý nhắc đã qua/đang enqueue thế nào?
- Recurrence và kỳ tiếp theo; retry, idempotency, delivery history và monitoring tối thiểu?
- Scheduler/queue cụ thể và quy tắc kiểm tra lại policy trước delivery để tránh gửi theo cấu hình cũ?

Không tự chọn chiến lược queue hay backfill khi chưa chốt behavior liên quan.

## References

- [API conventions](../../api/conventions.md)
- [Tracked items](../002-tracked-items/spec.md)

## API Implementation Baseline

Các quyết định API đã chốt nằm tại [ADR 0004](../../decisions/0004-api-auth-and-persistence.md) và [contract backend](../../../repos/soonio-api/docs/api.md). Phần mock/draft phía trên là lịch sử thiết kế; contract mới có ưu tiên với auth, wire format, defaults, date/time và pagination. PostgreSQL/Sanctum/Data + Actions đã triển khai; không chạy gửi email, recurrence rollover hoặc offline writes.
