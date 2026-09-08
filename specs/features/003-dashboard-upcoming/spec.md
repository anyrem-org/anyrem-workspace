# Dashboard / Upcoming

Status: in-progress

Behavior đã chốt và câu hỏi còn mở được phân biệt bên dưới. Acceptance criteria là dự thảo, chưa phải bằng chứng implementation.

## Goal

Giúp user biết việc gì cần chú ý tiếp theo, mốc nào sắp đến hạn và chi phí nào sắp phát sinh.

## Scope and Ownership

Backend sở hữu selection, ordering và cost aggregates theo business rules được chốt. Web/PWA sở hữu dashboard và Upcoming responsive; shared cung cấp presentation tái sử dụng nếu cần.

## Confirmed Behavior

- Thứ tự nội dung: Needs attention → Upcoming → Renewals/cost → All Items.
- Item hiển thị provider/icon nếu có, name, countdown hoặc due date, amount nếu có, status; cho mở detail.
- Ưu tiên wording “tomorrow”, “in 3 days”, “next week” hơn chỉ raw date. Ngày cụ thể có trong detail.
- Có thể có summary Due this week, Monthly recurring cost, Expiring soon; không nhiều chart.
- Primary action Add item rõ ràng. Mobile dùng list/card, desktop có thể dùng nhiều cột và summary cards.

## Dense Deadline Preview

Needs attention trên dashboard dùng danh sách compact tối đa 4 items theo due date tăng dần, kèm tổng số và breakdown overdue/today/next 4 days. Không mở rộng chiều cao theo tổng item và không dùng vùng cuộn lồng. View all/See more mở `/items?attention=1` để xem toàn bộ items quá hạn đến 4 ngày tới. Filter group giữ attention filter; user có thể bỏ attention bằng Show all dates. Item vẫn mở drawer trên nền danh sách đã lọc.

## Acceptance Criteria — Draft

- Hiển thị đúng thứ tự section; dữ liệu và aggregates được giới hạn theo user.
- Item không có amount/provider/group vẫn đọc được và mở detail được.
- Chưa có item có hướng dẫn và Add item; không có mốc gần có “Nothing due soon.”
- Loading/lỗi tải không bị hiển thị thành danh sách rỗng; lỗi có action thử lại.
- Relative date nhất quán với timezone/quy tắc được chốt; không cộng currency khác nhau tùy ý.
- Mobile không có sidebar cố định; keyboard tới được CTA, filters và item links.

## Open Questions Before Implementation

- Needs attention gồm trạng thái/ngưỡng nào, xử lý overdue ra sao, có trùng item giữa section không?
- Upcoming horizon, thứ tự trong section, ranh giới this week và Expiring soon?
- Công thức monthly recurring cost, billing cycles, multi-currency và missing amount?
- Countdown rounding, timezone và locale hiển thị?
- Quan hệ cụ thể giữa Overview/Upcoming, filters và refresh behavior?

## References

- [Tracked items](../002-tracked-items/spec.md)
- [UI guidelines](../../design/ui-guidelines.md)

## At a Glance — Mock

Ba card ngay dưới page heading, trước Needs attention: Upcoming deadlines, Upcoming payments, Expiring soon. Khoảng thống nhất từ hôm nay đến ngày thứ 29. BarChart chia deadline theo ngày 0–6, 7–13, 14–20, 21–29, có text số lượng tương ứng. Payments cộng amount ghi nhận theo currency riêng, không quy đổi recurrence hoặc dự báo kỳ tiếp theo; amount thiếu không được tính. Expiring gồm Trial, SSL, Credential rotation, Warranty, Contract trong mock. View items mở danh sách đúng bộ lọc. Mobile xếp dọc; desktop ba cột. Dữ liệu tổng hợp thật vẫn do backend sở hữu.

## Optional Time — Mock

Countdown chung cập nhật mỗi phút và khi quay lại tab. Timed item tính theo dueAt UTC, date-only quá hạn khi qua ngày theo timezone user. Bảng/group/dashboard dùng cùng sort và overdue; upcoming không cộng timed item đã quá hạn. Proximity dùng thời gian thực trên thang 30 ngày.

## API Implementation Baseline

Các quyết định API đã chốt nằm tại [ADR 0004](../../decisions/0004-api-auth-and-persistence.md) và [contract backend](../../../repos/soonio-api/docs/api.md). Phần mock/draft phía trên là lịch sử thiết kế; contract mới có ưu tiên với auth, wire format, defaults, date/time và pagination. PostgreSQL/Sanctum/Data + Actions đã triển khai; không chạy gửi email, recurrence rollover hoặc offline writes.

## Upcoming Deadlines Card — 2026-09-06

Card Các hạn sắp tới đếm item theo type trong 30 ngày tới; chỉ hiện type có item, không có ô chọn range hoặc bảng item thường trực. Hover, focus hoặc bấm một type mở popover với tối đa 10 item gần hạn nhất, giữ thứ tự API. Popover hiển thị tên/icon, số tiền nếu có, countdown/ngày hạn và số lượng đang xem/tổng số của type. Tên item là link mở detail drawer; link View items mở Upcoming lọc đúng type. Danh sách popover có cuộn giới hạn chiều cao, hỗ trợ keyboard và đóng bằng Escape.

Tải đủ các trang `/items?window=upcoming&sort=date` trước khi đếm theo type; không dùng preview 5 item của dashboard. Backend sở hữu selection và ordering. Có loading, lỗi/thử lại và empty state; refresh mỗi phút.
