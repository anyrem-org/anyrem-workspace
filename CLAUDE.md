# Soonio Workspace

Đọc [system overview](specs/architecture/system-overview.md) trước khi làm việc trong workspace này.

Sau đó đọc feature specification, architecture decision, [coding conventions](specs/engineering/coding-conventions.md) và hướng dẫn cục bộ liên quan trong repository owner dưới `repos/`. Với thay đổi UI, đọc [UI guidelines](specs/design/ui-guidelines.md).

Trước khi tạo, sửa hoặc xóa tài liệu, thông báo từng path và lý do theo quy tắc `Documentation Notice` trong coding conventions.

Laravel sở hữu dữ liệu và business logic; web/extension là client; UI dùng chung thuộc `soonio-shared`. Không coi spec draft hoặc câu hỏi còn mở là quyết định đã chốt. Giữ nguyên các thay đổi ngoài phạm vi của người dùng.

## Agent quality checks

- Dùng dependency local và lockfile; không dùng formatter từ project khác hoặc tự nâng dependency ngoài scope.
- Web/shared: trong `repos/soonio-web`, dùng Node theo `.nvmrc`, `pnpm install --frozen-lockfile`, rồi `pnpm check`. Lệnh này chạy ESLint, Prettier check, TypeScript, tests và build.
- API: trong `repos/soonio-api`, dùng `composer install`, rồi `composer check` (Pint, Larastan, PHPUnit). PHP CLI cần mbstring, pdo_pgsql và pdo_sqlite cho test suite hiện tại.
- Khi sửa code, format file trong scope và chạy regression test phù hợp. Không tắt rule, thêm baseline hoặc bỏ test chỉ để check xanh. Báo rõ lỗi tồn tại sẵn và kiểm tra bị môi trường chặn.
- Không coi build thành công là đã kiểm tra UI trên browser. Giữ thay đổi của user; không mass-format file ngoài scope.
