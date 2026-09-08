# Settings

## Goal

Cho phép người dùng kiểm soát preference cá nhân cho giao diện, regional behavior, search, Quick Access và recap.

## Scope

- `anyrem-desktop`: settings page, shortcut recorder và Telegram configuration UI.
- `anyrem-be`: user settings persistence, Telegram configuration và test delivery.

## Behavior

- Người dùng có thể thay đổi theme, activity panel, timezone và search history preference.
- Người dùng có thể chọn card hoặc list view mặc định, tách riêng cho category overview và category detail. Preference này được lưu theo user qua Settings API.
- Người dùng có thể xem hoặc đổi shortcut Quick Access.
- Người dùng có thể bật recap, chọn delivery time/provider và cấu hình hoặc xoá Telegram connection.
- Secret Telegram chỉ được gửi cho backend để lưu/xử lý; UI chỉ nhận trạng thái hoặc masked identifier.

## Acceptance Criteria

- Setting tồn tại sau khi tải lại session.
- Category overview và detail dùng lại view đã chọn cho đúng user sau khi mở lại ứng dụng.
- Shortcut bị hệ điều hành từ chối không thay thế shortcut đang hoạt động trên Windows/macOS.
- Telegram test chỉ hoạt động khi Telegram đã được cấu hình hợp lệ.
