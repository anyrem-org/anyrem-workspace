# Uploads

## Goal

Cho phép note editor lưu và hiển thị image asset qua backend thay vì lưu data URL dài trong nội dung note.

## Scope

- `anyrem-desktop`: gửi image data URL và dùng returned asset URL.
- `anyrem-be`: validate image, lưu upload và phục vụ asset qua public URL.

## Behavior

- Desktop gửi image data URL cùng tên file tới upload API.
- Backend chỉ chấp nhận image hợp lệ trong giới hạn kích thước.
- API trả asset path; desktop chuyển path thành absolute URL dựa trên API origin.
- Upload được gắn với user để backend kiểm soát dữ liệu sở hữu.

## Acceptance Criteria

- Image hợp lệ có thể được upload và hiển thị lại bằng returned URL.
- File không phải image hoặc vượt giới hạn bị từ chối.
- Upload failure không làm hỏng nội dung note đang soạn.
