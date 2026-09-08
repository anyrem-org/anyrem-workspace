# Notification Settings

Status: in-progress

Behavior đã chốt và câu hỏi còn mở được phân biệt bên dưới. Acceptance criteria là dự thảo, chưa phải bằng chứng implementation.

## Goal

Cho user đặt lịch nhắc chung, override từng item khi cần và tắt toàn bộ email từ một công tắc rõ ràng.

## Scope and Ownership

Đây là nguồn chính của notification policy. Backend sở hữu persistence, mode resolution và điều kiện gửi; web/PWA sở hữu global settings và item editor; extension dùng item editor phù hợp quick capture. Shared có thể cung cấp reminder controls thuần presentation. [Reminders](../005-reminders/spec.md) sở hữu delivery.

## Confirmed Global Behavior

- Email notifications có On/Off. Off dừng mọi email reminder, kể cả item Custom; giữ cấu hình lịch.
- Global default schedule là policy động cho item Default.
- UI cho xem/chỉnh các mốc nhắc, tùy chọn On due date và Add reminder.
- MVP chỉ email; không dựng UI chọn nhiều kênh ngay từ đầu.

## Confirmed Per-item Policy

| Mode | Schedule | Khi global schedule đổi | Khi Email Off |
| --- | --- | --- | --- |
| Default | Global schedule hiện tại | Tự áp dụng lịch mới | Không gửi email |
| Custom | Lịch riêng của item | Giữ nguyên lịch riêng | Không gửi email |
| Disabled | Không có lịch gửi hiệu lực | Không gửi reminder | Không gửi email |

Default không copy global schedule vào item tại thời điểm tạo. Backend phân giải policy hiện tại; client chỉ hiển thị và gửi lựa chọn. Đây là semantics, chưa chốt tên field/enum trên API.

Reset to default chuyển item Custom về Default và áp dụng global schedule hiện tại. Cách lưu/xóa lịch custom không hoạt động sau reset còn mở; nó không được tiếp tục là lịch hiệu lực.

## Settings Page — Mock

Navigation dùng tên Settings. Trang này gồm Language và Notifications. Language cho chọn English hoặc Tiếng Việt, lưu preference trên thiết bị khi Save settings; chưa tích hợp bản dịch toàn ứng dụng hoặc đồng bộ preference qua backend. UI phải nói rõ giới hạn mock này. Notification policy không thay đổi.

## UI Behavior

Trong More options của item, hiển thị “Reminder schedule” với ba lựa chọn:

- “Use default reminders”: kèm summary global hiện tại, ví dụ “7 days, 3 days, 1 day before”.
- “Custom reminders”: khi chọn mới mở editor các mốc nhắc và Add reminder.
- “Don't remind me for this item”: chọn Disabled.

Custom có “Reset to default”. Editor có thể diễn đạt “Remind me [5] [days] before”; các units/limits được hỗ trợ cần chốt trước implementation. Khi global Email Off, UI giải thích mọi email đang dừng nhưng cấu hình vẫn được giữ; không đổi mode item ngầm.

## Proposed Defaults — Draft

Global schedule dự kiến: 7, 3, 1 ngày trước hạn; On due date chưa chọn. Đây là đề xuất, chưa phải cấu hình đã triển khai. Email mặc định On/Off và default mode cho item mới cần chốt trước implementation; UI gợi ý Use default reminders làm lựa chọn khởi đầu.

## Acceptance Criteria — Draft

- Sửa global schedule làm item Default dùng lịch mới mà không cập nhật từng bản sao lịch trên item.
- Item Custom giữ nguyên lịch khi global schedule đổi.
- Item Disabled không gửi reminder.
- Email Off chặn cả Default và Custom; lịch global/custom và mode được giữ nguyên.
- Reset to default khôi phục kế thừa động; thay global lần tiếp theo vẫn tác động item đó.
- Global settings và mode/custom schedule của item được lưu theo user, tải lại phản ánh cấu hình đã lưu.
- Default summary phản ánh global schedule hiện tại sau khi dữ liệu được refresh; chỉ Custom mở custom editor.
- Lỗi lưu giữ input và hướng dẫn thử lại/sửa; controls dùng được trên mobile và bằng keyboard.
- Backend validate và kiểm tra ownership, không dựa vào client để quyết định gửi.

## Open Questions Before Implementation

- Chốt proposed default schedule, Email mặc định On/Off và initial item mode?
- Giờ gửi, timezone và On due date có nghĩa vào thời điểm nào?
- Custom units/limits, offset bằng 0, số lượng mốc, trùng mốc, lịch rỗng và validation?
- Chuyển qua lại Custom/Disabled/Default có giữ lịch custom nháp không?
- Pending reminders khi thay settings, bật lại email hoặc đổi deadline; có gửi bù mốc đã qua không?
- Settings save explicit/auto-save và xử lý cập nhật đồng thời?

## References

- [UI guidelines](../../design/ui-guidelines.md)
- [API conventions](../../api/conventions.md)

## Date/Time Display — Mock

Settings lấy options (ID, label, Luxon dateFormat/timeFormat) và default ID qua GET /settings/options của API mock. Save settings lưu ID; mock từ chối ID không hỗ trợ. Formatter chung dùng cache settings/options, áp dụng sau Save cho dashboard, bảng và item detail. Dữ liệu cũ dùng default server; reload giữ lựa chọn. Date-only không thêm giờ giả; datetime dùng cả date/time format. Native date input theo trình duyệt, countdown tương đối và timezone/reminder policy không thay đổi. Endpoint thật cần chốt trong contract backend.

## Optional Time — Mock

Timezone lấy options từ API mock. Dữ liệu cũ khởi tạo timezone trình duyệt, fallback UTC và lưu lại. Đổi timezone giữ dueAt UTC, chỉ đổi hiển thị; date-only giữ ngày. Date/time format áp dụng cả giờ. Không đổi reminder policy.

## API Implementation Baseline

Các quyết định API đã chốt nằm tại [ADR 0004](../../decisions/0004-api-auth-and-persistence.md) và [contract backend](../../../repos/soonio-api/docs/api.md). Phần mock/draft phía trên là lịch sử thiết kế; contract mới có ưu tiên với auth, wire format, defaults, date/time và pagination. PostgreSQL/Sanctum/Data + Actions đã triển khai; không chạy gửi email, recurrence rollover hoặc offline writes.

## Due-soon threshold — UI mock

Settings có cấu hình số ngày để phân loại “Sắp đến hạn”, áp dụng chung cho nhãn deadline, màu cảnh báo và filter. Ví dụ ngưỡng 3 ngày: ngày mai đến hết ngày thứ 3 là Due soon; sau đó là Upcoming. Due today và Overdue vẫn riêng, dùng timezone/countdown hiện có. Không đổi reminder schedule, dashboard selection/aggregates hoặc thang progress 30 ngày.

Development mock mặc định 7 ngày, cho nhập số nguyên 1–365 và bấm “Áp dụng ngưỡng”. Giữ trong React context của phiên đăng nhập, reload reset. Đây là giới hạn/default mock; validation, persistence theo user và classification/query thật thuộc backend triển khai sau. Không thêm field hoặc request vào API hiện tại.
