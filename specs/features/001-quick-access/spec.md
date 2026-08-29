# Quick Access

## Goal

Cho phép người dùng tìm kiếm hoặc tạo note ngay từ global shortcut, không cần mở toàn bộ main window.

## Scope

- `anyrem-desktop`: Electron main process, preload bridge và renderer route cho Quick Search/Quick Create.
- Dùng API note, category và search hiện có của backend; feature này không tạo HTTP API mới.
- MCP và infrastructure ngoài scope.

## Behavior

- Global shortcut mở Quick Search hoặc Quick Create trong cửa sổ overlay riêng, frameless, always-on-top và không xuất hiện ở taskbar.
- Main window có thể tiếp tục ẩn ở tray/background; Quick Access không tự mở full app.
- Quick Search tự focus input, tìm note theo relevance, cho phép dùng mũi tên để chọn và Enter để xem detail.
- Từ Quick Search, người dùng có thể mở full note trong main window; quick window được ẩn trước khi điều hướng.
- Quick Create cho phép nhập nội dung BlockNote, chọn category/related note không bắt buộc và lưu bằng nút Save hoặc Ctrl/Cmd + Enter.
- Quick window ẩn khi người dùng đóng, nhấn Esc hoặc chuyển focus sau khoảng thời gian bảo vệ ngắn để tránh blur ngay sau global shortcut.
- Shortcut có thể được cấu hình trong desktop settings. Việc đăng ký shortcut phụ thuộc OS và shortcut đang được ứng dụng khác sử dụng.

## Constraints

- Giữ `contextIsolation: true` và `nodeIntegration: false`.
- Renderer chỉ gọi Electron main process qua preload và `contextBridge`.
- Không tạo endpoint hoặc state riêng chỉ cho Quick Access nếu API note/search hiện có đã đáp ứng.

## Acceptance Criteria

- Khi shortcut đăng ký thành công, Quick Search hoặc Quick Create xuất hiện mà không làm main window hiện ra.
- Quick Search có thể tìm, chọn, xem detail và mở note đầy đủ.
- Quick Create lưu note thành công với category và related note là optional.
- Esc hoặc close action chỉ ẩn quick window; không thoát ứng dụng.
- Quick Access giữ các boundary bảo mật Electron đã nêu trong Constraints.
