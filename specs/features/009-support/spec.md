# Support Soonio

Status: in-progress

## UI behavior

Development mock: “Ủng hộ Soonio / Support Soonio” ở cuối sidebar và cuối Settings để mobile truy cập được. Người dùng chủ động mở modal; không tự hiện popup hoặc thêm CTA vào dashboard. Modal nhỏ desktop, toàn màn hình mobile, hỗ trợ vi/en.

Hai phương thức: Chuyển khoản QR và Buy Me a Coffee. Khi mở, locale vi chọn QR, en chọn Buy Me a Coffee. QR có chỗ hiển thị ảnh, ngân hàng, người nhận, số tài khoản, action sao chép và tải QR. Buy Me a Coffee có CTA và mô tả mở trang ngoài. Không nhập số tiền, không có action xác nhận đã thanh toán.

## Mock boundaries

Chưa có tài khoản nhận tiền, QR hoặc URL Buy Me a Coffee được user cung cấp. Hiển thị placeholder rõ ràng; copy/download và mở trang thanh toán đều disabled. Không tạo QR có thể thanh toán, không dùng tài khoản hoặc liên kết giả. Không gọi backend, không xác nhận giao dịch.

Khi có thông tin thanh toán đã xác nhận, cần nối dữ liệu thật và kiểm tra copy/download/link trước khi bật production.

## Donation tree demo

Frontend-only demo nằm trong Support modal; development preview độc lập tại `/preview/donation-tree`, không cần đăng nhập. Card dùng Mantine/theme hiện tại và SVG, hiển thị “Support Soonio”, số tiền còn tới mốc kế tiếp, progress và tổng hỗ trợ. Copy demo dùng tiếng Anh theo yêu cầu. State bắt đầu từ 0 khi component mount; không lưu hoặc gửi backend.

“Demo successful donation” mô phỏng +20,000 VND mỗi lần: khóa nút → bình tưới nghiêng và giọt nước rơi → đất phản ứng, cập nhật tổng và animate progress → nếu vượt mốc, chuyển cây với fade/growth bounce → idle sway nhẹ và mở nút. Mốc tổng: 0 (hạt/đất), 20,000 (mầm hai lá), 50,000 (cây non nhiều lá), 100,000 (cây nhỏ), 200,000 VND (cây trưởng thành). Progress tính trong khoảng giữa hai mốc; khi đạt mốc, thanh cũ đầy trước khi chuyển sang khoảng kế tiếp.

Mốc cuối hiển thị “Tree fully grown”, progress 100%; lần hỗ trợ sau vẫn tưới và cộng tổng nhưng không chuyển stage. Reduced motion cập nhật ngay, không đợi animation; đổi preference giữa chuỗi hoàn tất donation đúng một lần. Có accessible SVG label, progress và live status; nút dùng keyboard được.

`useDonationTree().simulateDonationSuccess(amount)` là điểm vào độc lập provider; reducer quản lý donation total và animation phase riêng, helpers tính stage/progress tập trung. Demo xử lý một donation mỗi lần, bỏ qua trigger khi đang bận hoặc amount không phải số nguyên VND dương an toàn. Khi nối event thật, adapter `DonationCompleted`/payment completed cần dùng amount đã được backend xác nhận, deduplicate và queue event trước điểm vào; dữ liệu thật và business rules vẫn thuộc Laravel. Chưa tích hợp payment provider hay xác nhận giao dịch thật.
