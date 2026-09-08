# Soonio UI Guidelines

## Goals and Visual Style

Mobile-first, đơn giản, sạch và dễ hiểu ngay lần đầu; phù hợp phần lớn user. Ưu tiên việc cần hành động tiếp theo hơn analytics. Modern, minimal, calm; typography rõ, khoảng trắng thoáng, card đơn giản, hạn chế shadow/border nặng. Màu warning chỉ dùng khi có tình huống cần chú ý, luôn kèm text/icon dễ hiểu.

Dùng React + TypeScript, Mantine và Lucide React theo [coding conventions](../engineering/coding-conventions.md). Components tái sử dụng thuộc shared; không làm UI giống finance app phức tạp hoặc enterprise admin dashboard.

## Information Architecture and Responsive Behavior

Web/PWA dùng cùng navigation và nội dung. Các điểm đến gồm Overview, Upcoming, All Items, Groups và Notification Settings. Auth, Add Item và Item Detail/Edit hỗ trợ core flow. Route paths chưa chốt.

Desktop có sidebar, Groups và action New Group; mỗi group có thể hiển thị item count. Mobile không có sidebar cố định: header compact hoặc bottom navigation, group filter dạng dropdown/chips, Add button sticky/floating dễ thao tác một tay. Navigation pattern cụ thể sẽ chốt khi triển khai UI, không cần dựng nhiều biến thể trong bước tài liệu.

Danh sách dữ liệu dùng semantic table trên desktop và mobile, với header rõ ràng. Mobile cuộn ngang trong vùng bảng có thể focus bằng keyboard, không làm tràn toàn trang; giữ tên item và due date ở các cột đầu. Navigation và các lựa chọn trong form vẫn dùng control phù hợp. Mỗi màn hình có primary action rõ, ví dụ Add item, Save item hoặc Save settings; không để CTA sticky che nội dung, lỗi hoặc focus.

## Dashboard and Item Presentation

Ưu tiên Needs attention → Upcoming → Renewals/cost → All Items. Mỗi item hiển thị provider/icon nếu có, name, countdown/due date, amount nếu có và status. Có icon dự phòng trung tính khi không xác định được provider; không dùng icon làm thông tin duy nhất.

Ưu tiên wording như “Renews tomorrow · $20”, “Expires in 4 days” hoặc “next week”; ngày cụ thể vẫn cần truy cập rõ trong detail. Không suy ra quy tắc countdown/timezone trước khi được chốt.

Summary có thể gồm Due this week, Monthly recurring cost và Expiring soon; không cần nhiều chart. Chỉ hiển thị cost summary có nghĩa theo quy tắc tiền tệ/recurrence đã chốt, không cộng nhiều currency thành một số tùy ý.

## Forms and Details

Add Item mặc định gồm Name, Type, Due/Renewal date. More options chứa Amount, Currency, Billing cycle, Auto renew, Group, URL, Notes và Reminder schedule. Không yêu cầu user nhập lại dữ liệu đã có hoặc có default hợp lệ; cho phép sửa metadata prefill.

Detail/Edit hiển thị name, provider, type, date, amount, recurrence, reminders, group, source URL và notes khi có; cho phép edit nhanh. Confirmation chỉ cho destructive action. All Items hỗ trợ search, type/group filter và due date/amount sort.

Reminder editor theo [Notification Settings](../features/006-notification-settings/spec.md): hiển thị Default với summary hiện tại, Custom mở editor, Disabled tắt nhắc và Reset to default quay về kế thừa. Công tắc Email Off phải giải thích rõ mọi email reminder đang dừng, lịch vẫn được giữ.

## Accessibility and Interaction

- Dùng semantic controls, label rõ cho mọi field; icon-only buttons có accessible name.
- Keyboard dùng được toàn bộ form/navigation; focus nhìn thấy rõ, thứ tự hợp lý. Modal quản lý focus, trả focus về trigger sau đóng; không tạo keyboard trap.
- Touch targets đủ lớn và tách biệt để thao tác mobile; dùng kích thước tối thiểu nội bộ 44 × 44 CSS px cho control chính.
- Text dễ đọc, contrast rõ; không chỉ dùng màu để thể hiện error/status. Hỗ trợ zoom và reflow không mất nội dung/chức năng.
- Label, description và lỗi liên kết với input; thông báo lưu/lỗi có thể được công nghệ hỗ trợ nhận biết. Tôn trọng reduced motion.

## Loading, Empty and Error States

Loading phân biệt với danh sách rỗng; hiển thị trạng thái đang tải/lưu, tránh gửi lặp khi mutation pending. Lỗi tải có action thử lại; lỗi lưu giữ dữ liệu đã nhập để user sửa hoặc thử lại.

Chưa có item: “Add your first item to start tracking renewals and deadlines.” với CTA “Add item”. Có items nhưng không có hạn gần: “Nothing due soon.” Filter không khớp: giải thích và cho phép bỏ filter.

Lỗi nói rõ user cần làm gì. “Choose a renewal date after today” chỉ là ví dụ cách viết thay cho “Invalid date”, không phải quyết định cấm chọn ngày quá hạn. Error copy phải khớp validation thật.

## Validation Scenarios

Kiểm tra mobile/desktop, keyboard-only, focus khi mở/đóng modal, nội dung dài, item không có amount/group/provider, loading/empty/error và CTA không che nội dung. Behavior chi tiết và acceptance dự thảo thuộc từng feature spec.

## Deadline Emphasis

Item cards, lists và detail dùng countdown nổi bật kèm ngày cụ thể và thanh deadline proximity. Thang UI mock cố định 30 ngày: thanh đầy dần khi gần hạn, không phải phần trăm hoàn thành hoặc thời gian đã dùng của billing cycle. Ngoài 30 ngày thanh rỗng nhưng nhãn vẫn ghi số ngày; đến/quá hạn thanh đầy. Xanh khi còn hơn 7 ngày, vàng khi còn 1–7 ngày, đỏ khi hôm nay/quá hạn. Có text Tomorrow/Today/Overdue và accessible meter description, không truyền đạt chỉ bằng màu. Thang này không thay đổi selection rules của Needs attention hoặc reminder policy.

## Table Pagination — Mock

All Items, Upcoming, kết quả Needs attention và Groups dùng phân trang local sau khi filter/sort: mặc định 10 dòng, chọn 20/50, hiển thị khoảng dòng/tổng số. Đổi filter/search/sort quay về trang đầu; khi xóa làm giảm số trang thì lùi về trang hợp lệ. Mở/đóng item drawer giữ trang hiện tại. Dashboard giữ preview ngắn và View all. Shared cung cấp control qua props; pagination API thật vẫn thuộc contract backend cần chốt.
