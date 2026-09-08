# AnyRem Glossary

## Terms

| Term | Definition |
| --- | --- |
| **AnyRem** | Personal memory app giúp người dùng ghi lại và tìm lại thông tin trong quá trình làm việc. |
| **User** | Người sở hữu dữ liệu cá nhân trong AnyRem. Mọi note, category, search history và recap được tách theo user. |
| **Note** | Đơn vị kiến thức chính người dùng lưu lại. Note có title, nội dung rich text, trạng thái pinned và có thể thuộc nhiều category. Trong UI có thể gọi là “memory”, nhưng tên domain và API chuẩn là `note`. |
| **Quick Capture** | Hành động tạo note với số thao tác tối thiểu, thường từ Quick Create window hoặc màn hình tạo note. |
| **Quick Access** | Các cửa sổ overlay nhẹ mở qua global shortcut, gồm Quick Search và Quick Create; không yêu cầu mở toàn bộ main window. |
| **Quick Search** | Trải nghiệm tìm kiếm nhanh qua global shortcut hoặc overlay window. |
| **Search** | Khả năng tìm note theo từ khoá và filter. Search là trải nghiệm trung tâm của sản phẩm, không phải công cụ quản trị dữ liệu. |
| **Search History** | Danh sách từ khoá mà một user đã tìm, dùng để mở lại hoặc gợi ý truy vấn gần đây. |
| **Category** | Cách tổ chức note nhẹ theo chủ đề. Một category thuộc một user; một note có thể thuộc nhiều category. |
| **Related Note** | Note có ngữ cảnh liên quan tới note đang xem. Relation có thể do người dùng tạo hoặc do hệ thống xác định từ dữ liệu hiện có. |
| **Pinned Note** | Note người dùng đánh dấu ưu tiên để dễ tìm hoặc hiển thị trước. |
| **Inbox Item** | Mục cần xử lý nhanh trong inbox cá nhân, có thể đánh dấu hoàn thành. Inbox item không đồng nghĩa với note. |
| **Daily Recap** | Bản tổng hợp note của một ngày theo múi giờ người dùng, dùng để nhắc lại kiến thức đã ghi. |
| **Delivery** | Một lần gửi Daily Recap qua một provider, ví dụ email hoặc Telegram; có trạng thái gửi riêng. |
| **Provider** | Kênh phân phối recap, hiện gồm email và Telegram. |
| **Desktop** | Ứng dụng Electron dành cho người dùng cuối, thuộc repository `anyrem-desktop`. |
| **Backend** | NestJS service xử lý business behavior, authorization, database, search và jobs, thuộc repository `anyrem-be`. |
| **MCP** | Model Context Protocol server cung cấp tool AnyRem cho AI client, thuộc repository `anyrem-mcp`. |
| **API Contract** | Quy ước request/response HTTP giữa backend và consumer. `anyrem-be` là owner duy nhất; OpenAPI được generate từ backend. |
| **Workspace** | Repository `anyrem-workspace` chứa product specification, kiến trúc xuyên repository, convention và architecture decision. |
| **Repository Owner** | Repository chịu trách nhiệm sửa code, test và technical documentation cho một capability. |
