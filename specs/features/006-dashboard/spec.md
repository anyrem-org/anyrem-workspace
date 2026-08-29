# Dashboard

## Goal

Hiển thị Memory Hub giúp người dùng biết đã capture gì, tiếp tục ở đâu và tìm lại nhanh.

## Scope

- `anyrem-desktop`: dashboard page và navigation tới note/category/search liên quan.
- `anyrem-be`: dashboard aggregate API.

## Behavior

- Dashboard hiển thị note hôm nay, note cần tiếp tục, recently active note, top category và recap preview.
- Dashboard ưu tiên thao tác mở/tìm note thay vì analytics hoặc biểu đồ không phục vụ recall.
- Dữ liệu dashboard thuộc user đã xác thực.

## Acceptance Criteria

- Dashboard chịu được dữ liệu rỗng và vẫn cho phép người dùng bắt đầu search hoặc tạo note.
- Note/category mở từ dashboard dẫn đúng resource của user.
- Recap preview phản ánh dữ liệu backend trả về.
