# Daily Recap

## Goal

Nhắc người dùng xem lại note đã tạo hoặc cập nhật trong ngày qua kênh đã cấu hình.

## Scope

- `anyrem-be`: generate summary theo timezone user, scheduled delivery, delivery history và provider integration.
- `anyrem-desktop`: recap preview trong dashboard và test delivery từ settings.

## Behavior

- Backend tạo một daily summary cho mỗi user/ngày local timezone.
- Recap tổng hợp note được tạo hoặc cập nhật trong ngày theo category.
- Delivery có trạng thái riêng theo provider email hoặc Telegram.
- Người dùng chỉ nhận recap qua provider đã enable và đủ điều kiện cấu hình.

## Acceptance Criteria

- Một user không nhận duplicate summary cho cùng ngày local.
- Test delivery không làm thay đổi dữ liệu note.
- Delivery failure được lưu trạng thái mà không làm lộ secret provider.
