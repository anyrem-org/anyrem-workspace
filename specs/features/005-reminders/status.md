# Reminders Status

Status: draft

Last Reviewed: 2026-09-05

## Progress by Repository

| Repository | Progress |
| --- | --- |
| `soonio-api` | Chưa triển khai trong phạm vi feature Soonio; chưa kiểm chứng. |
| `soonio-web` | Chưa triển khai trong phạm vi feature Soonio; chưa kiểm chứng. |
| `soonio-extension` | Chưa triển khai trong phạm vi feature Soonio; chưa kiểm chứng. |

`soonio-shared`: chưa tạo component/package trong scope tài liệu; chỉ tham gia khi có UI tái sử dụng thực tế.

## Acceptance State

Chưa kiểm chứng. Các tiêu chí trong [spec](spec.md) là dự thảo; không kế thừa kết quả hoặc trạng thái implementation của sản phẩm trước.

## Next Step

Chốt các Open Questions ảnh hưởng phần sắp triển khai, sau đó implement và kiểm tra tại repository owner. Cập nhật status bằng bằng chứng thực tế.

## API Integration Update — 2026-09-05

Backend: implemented auth, CRUD groups/items, settings/options, dashboard và effective reminder policy; tests PostgreSQL xác minh 5 cases/53 assertions ở thời điểm cập nhật. React: kết nối Axios thật, cookie auth và options vi/en; kiểm thử trình duyệt đang thực hiện. Email worker/recurrence advancement chưa triển khai. Feature tổng thể chưa đánh dấu verified.
