# User feedback

Status: in-progress

## Goal

User gửi phản hồi đủ ngữ cảnh để maintainer hiểu lỗi hoặc đề xuất. Increment hiện tại chỉ mock UI; chưa triển khai backend.

## UI mock

- Nút Góp ý/Feedback trên topbar mở drawer bên phải, toàn màn hình trên mobile. Chỉ bật trong development.
- Loại: Bug report, Feature request, Usability improvement, Other.
- Bắt buộc tiêu đề và mô tả; giới hạn mock lần lượt 160 và 5.000 ký tự.
- Bug report thêm các bước tái hiện, kết quả mong đợi/thực tế và mức ảnh hưởng: vẫn dùng được, cần workaround, bị chặn công việc. Các field bổ sung không bắt buộc.
- Trang liên quan lấy pathname hiện tại khi mở lần đầu, cho sửa. Email liên hệ tùy chọn, prefill tài khoản đăng nhập. Không tự thu thập query string, browser logs hoặc dữ liệu item.
- Chọn tối đa 5 ảnh PNG/JPEG/WebP, mỗi ảnh có dữ liệu và không quá 5 MB. Hiển thị thumbnail, filename, dung lượng và action xóa; từ chối batch không hợp lệ mà giữ ảnh cũ. Object URLs được thu hồi khi thumbnail unmount.
- Điền form → Gửi thử (mock) → xác nhận rõ chưa gửi/lưu lên server → tạo phản hồi khác. Đóng/mở drawer giữ draft trong phiên; reload reset.
- Copy hỗ trợ vi/en theo locale tài khoản. Validation field, lỗi file, confirmation state có thông tin văn bản; Mantine quản lý focus drawer.

## Ownership and pending backend decisions

Frontend sở hữu form và presentation; backend tương lai sở hữu validation, lưu phản hồi, upload và delivery/triage. Chưa chốt API contract, nơi nhận, attachment storage, policy file, retention hoặc workflow maintainer. Mock không gọi API feedback, upload file hay gửi thông báo.

## Validation

Kiểm tra type thay đổi, field bắt buộc, file count/type/size, xóa và chọn lại ảnh, gửi trực tiếp từ form, submit mock và desktop/mobile keyboard. Không coi build là browser verification.
