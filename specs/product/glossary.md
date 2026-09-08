# Soonio Glossary

| Term | Definition |
| --- | --- |
| Soonio | Sản phẩm theo dõi các mốc đến hạn, chi phí sắp phát sinh và hành động cần làm. |
| User | Người sở hữu items, groups và notification settings cá nhân. |
| Tracked item / Item | Đơn vị theo dõi chính, có name, type và due/renewal/expiry date; amount và group là optional. Chưa chốt tên field trên API. |
| Type | Item là gì: subscription, trial, domain/SSL, credential rotation, warranty, contract hoặc deadline khác; enum cuối cùng còn mở. |
| Group | Context tùy chỉnh như Work hoặc Personal; một cấp, optional, tối đa một group cho mỗi item. |
| Due date / Deadline | Mốc cần hành động; quy tắc date-only, timezone và ngày quá hạn cần chốt trong contract. |
| Renewal | Mốc gia hạn; không mặc nhiên đồng nghĩa với hệ thống thanh toán hoặc tự chuyển ngày. |
| Expiry | Mốc hết hiệu lực của item. |
| Amount / Currency | Giá trị tiền và loại tiền nếu có; quy tắc biểu diễn/tổng hợp còn mở. |
| Billing cycle / Recurrence | Chu kỳ chi phí hoặc lặp lại; behavior cập nhật kỳ tiếp theo chưa chốt. |
| Auto renew | Thông tin về gia hạn tự động của item; không phải yêu cầu Soonio thực hiện thanh toán. |
| Upcoming | Items sắp đến hạn; khoảng thời gian cụ thể còn mở. |
| Needs attention | Items cần người dùng chú ý trước; tiêu chí và thứ tự ưu tiên còn mở. |
| Reminder schedule | Các mốc nhắc tương đối với deadline. |
| Global default schedule | Lịch mặc định hiện tại của user, được item Default kế thừa động. |
| Default | Mode dùng global schedule hiện tại, không chụp/copy lịch vào item. |
| Custom | Mode dùng lịch riêng của item, không đổi theo global schedule. |
| Disabled | Mode không gửi reminder cho item. |
| Email notifications | Công tắc kênh toàn cục; Off chặn mọi email reminder, kể cả Custom, và giữ cấu hình lịch. |
| Effective schedule | Lịch backend xác định từ mode của item và settings hiện tại; gửi còn phụ thuộc công tắc email. |
| Reset to default | Chuyển item từ Custom về Default để kế thừa global schedule hiện tại. |
| Quick capture | Thêm item từ Chrome bằng metadata tab hiện tại và thông tin user nhập. |
| Provider | Dịch vụ/đơn vị gắn với item, dùng cho thông tin hiển thị; cách xác định còn mở. |
| Web / PWA | Hai cách truy cập cùng ứng dụng và information architecture trong `soonio-web`; offline behavior chưa chốt. |
| Shared UI | Components, primitives và theme tái sử dụng trong `soonio-shared`. |
| API contract | Request/response và hành vi HTTP do `soonio-api` sở hữu. |
| Workspace | Nơi chứa specifications, UI guidelines, conventions và ADR xuyên repository. |

Policy chi tiết nằm tại [Notification Settings](../features/006-notification-settings/spec.md); thuật ngữ ở đây không định nghĩa wire format.
