# AnyRem Product Vision

## Purpose

AnyRem là personal memory app cho developer và knowledge worker. Sản phẩm giúp người dùng ghi lại thông tin xuất hiện trong lúc làm việc, sau đó tìm lại nhanh và tiếp tục đúng ngữ cảnh.

AnyRem không phải Notion clone hay công cụ quản lý dự án tổng quát. Giá trị cốt lõi là giảm nỗ lực để ghi nhớ và tìm lại kiến thức cá nhân.

## Target Users

Sản phẩm phục vụ người thường xuyên phải giữ nhiều thông tin ngắn hạn hoặc phân tán trong quá trình làm việc: developer, product/knowledge worker và người làm việc với tài liệu, ý tưởng, quyết định hoặc liên kết tham khảo.

## Value Promise

- Ghi lại thông tin ngay khi nó xuất hiện, không làm gián đoạn công việc.
- Tìm lại note như tìm kiếm trên web: nhanh, rõ và theo đúng ngữ cảnh.
- Nhìn thấy nội dung liên quan để tiếp tục công việc thay vì tự nhớ lại từ đầu.
- Được nhắc lại những gì đã ghi qua daily recap để kiến thức không bị bỏ quên.

## Core Loop

```text
Đang làm việc
→ ghi note nhanh
→ lưu và tổ chức tối thiểu
→ tìm lại bằng từ khoá
→ mở note và nội dung liên quan
→ nhận recap để ôn lại
```

Mọi feature nên hỗ trợ trực tiếp ít nhất một bước của core loop này.

## Product Principles

- Tốc độ capture và retrieval quan trọng hơn số lượng tính năng.
- Search là trải nghiệm trung tâm, không phải màn hình phụ.
- Organisation phải nhẹ: category, tag hoặc metadata chỉ được yêu cầu khi thực sự giúp người dùng tìm lại.
- Nội dung liên quan cần giải thích được bằng ngữ cảnh hiện có trước khi thêm AI phức tạp.
- Product ưu tiên dữ liệu và trải nghiệm đáng tin cậy trước khi thêm insight hoặc automation nâng cao.
- Desktop-first: quick access, global shortcut và tray/background behavior phải giúp thao tác nhanh mà không mở toàn bộ ứng dụng.

## Product Boundaries

- Không mở rộng thành workspace cộng tác, project management hoặc document suite tổng quát.
- Không đưa AI summary, semantic search hoặc offline sync vào core scope trước khi capture, search và recap hoạt động ổn định.
- Không để desktop hoặc MCP gọi trực tiếp search engine; mọi truy cập dữ liệu đi qua backend để bảo vệ quyền và dữ liệu người dùng.

## Success Direction

Sản phẩm đi đúng hướng khi người dùng tin rằng: bất cứ điều gì đáng nhớ trong lúc làm việc đều có thể ghi lại ngay, và họ có thể tìm lại nó khi cần mà không phải nhớ chính xác đã lưu ở đâu.
