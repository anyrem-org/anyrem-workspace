# Production Backup

## Goal

Sao lưu dữ liệu production off-site (object storage) để có thể khôi phục sau sự cố server hoặc mất dữ liệu local.

## Scope

- `anyrem-infra`: script shell, cron và installer trên VPS production.
- `anyrem-be`: script upload archive lên object storage và thông báo qua worker/Telegram.
- Ngoài scope: backup Meilisearch (reindex từ Postgres), Redis (ephemeral), avatar volume (có thể tái tạo bằng `pnpm avatars:sync`).

## Data Covered

| Dữ liệu | Nguồn | Object key (UTC date) | Bắt buộc |
| --- | --- | --- | --- |
| PostgreSQL | `pg_dump` trên host | `db/daily/YYYY-MM-DD.sql.gz` | Có |
| Note image files | Docker volume `anyrem_uploads` | `uploads/YYYY-MM-DD.tar.gz` | Có khi có ảnh trong note |

Postgres chứa metadata bảng `uploads` (path, `noteId`, …); binary ảnh nằm trên volume, không nằm trong dump.

## Behavior

### Database backup

1. Cron trên VPS chạy `anyrem-db-backup.sh`.
2. Script dump Postgres bằng `pg_dump`, nén `gzip`, ghi file tạm trên host.
3. Container backend chạy `node dist/backup/backup.script.js --type db-daily --file <archive>`.
4. Script upload lên object storage, enqueue thông báo Telegram qua worker.
5. File tạm trên host bị xóa sau khi upload thành công.

### Uploads backup

1. Cron trên VPS chạy `anyrem-uploads-backup.sh`.
2. Container Alpine đọc volume `anyrem_uploads` (read-only), tạo `tar.gz` trên host.
3. Container backend chạy `node dist/backup/backup.script.js --type uploads --file <archive>`.
4. Script upload lên object storage, enqueue thông báo Telegram qua worker.
5. File tạm trên host bị xóa sau khi upload thành công.

Archive uploads phải giữ cấu trúc `note-images/{userId}/{yyyy}/{mm}/{uuid}.ext` ở root để restore khớp mount `/app/uploads`.

### Notifications

- Backup started, completed và failed được gửi qua queue `backup-notify`; worker gửi Telegram tới channel deploy.
- Dedupe job id theo key object để tránh spam khi retry.

### Prerequisites (production)

- `/opt/anyrem-be/.env.production` có `OBJECT_STORAGE_*`, `REDIS_URL`, `TELEGRAM_BOT_TOKEN`, `PRODUCT_DEPLOY_TELEGRAM_ID`.
- `BACKUP_DATABASE_URL` hoặc `DATABASE_URL` (script DB thay `host.docker.internal` → `127.0.0.1` khi cần).
- Container `anyrem-be-worker` đang chạy.
- Image backend đã deploy chứa `dist/backup/backup.script.js`.

## Restore (minimum)

1. Restore Postgres từ `db/daily/YYYY-MM-DD.sql.gz`.
2. Restore uploads volume từ `uploads/YYYY-MM-DD.tar.gz` (extract vào `/app/uploads`).
3. Chạy `prisma migrate deploy` nếu schema mới hơn dump.
4. Chạy `pnpm search:reindex` (Meilisearch).
5. Xác minh: login, mở note có ảnh, search.

Chi tiết vận hành: `repos/anyrem-infra/backup/README.md`.

## Acceptance Criteria

- Backup DB hàng ngày tạo object `db/daily/YYYY-MM-DD.sql.gz` trên object storage.
- Backup uploads hàng ngày tạo object `uploads/YYYY-MM-DD.tar.gz` khi volume có dữ liệu.
- Upload thành công hoặc thất bại đều có thông báo Telegram.
- Restore drill Postgres + uploads đã được thử ít nhất một lần trên môi trường không phải production trước khi bật cron production.
