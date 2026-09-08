# Soonio Workspace

Soonio giúp người dùng biết cái gì sắp đến hạn, cái gì sắp tốn tiền và cần hành động gì trước deadline. Sản phẩm gồm web app + PWA và Chrome extension.

Workspace sở hữu product specification, thiết kế UI, kiến trúc xuyên repository và conventions. Code và technical documentation thuộc repository owner dưới `repos/`; mỗi repository có Git history và quy trình phát hành riêng. `repos/` không được Git workspace theo dõi.

## Repository Layout

```text
repos/
├── soonio-api/        # Laravel REST API và business logic
├── soonio-web/        # React SPA + PWA
├── soonio-extension/  # WXT + React Chrome extension
└── soonio-shared/     # UI components, primitives và theme dùng chung
```

Đây là tên và layout mục tiêu, không phải xác nhận các repository đã được triển khai.

## Setup Status

`scripts/bootstrap.sh` hiện dùng tên `soonio-ext`, chưa có `soonio-shared`. `soonio-workspace.code-workspace` vẫn chứa các đường dẫn AnyRem cũ. Chuẩn hóa script, cấu hình IDE, tên thư mục và xác minh remote là bước riêng trước khi dùng setup này cho Soonio. Không suy đoán URL remote mới.

Bootstrap hiện giữ nguyên mọi target đã tồn tại, kể cả thư mục trống; sự tồn tại của folder không chứng minh repository đã được clone. Lần chuẩn hóa tài liệu này không thay đổi script hoặc cấu hình IDE.

## Working on a Feature

1. Đọc [hướng dẫn agent](AGENTS.md) và [system overview](specs/architecture/system-overview.md).
2. Đọc feature spec, ADR và conventions liên quan; chốt các câu hỏi còn mở ảnh hưởng đến phần sắp triển khai.
3. Đọc hướng dẫn cục bộ, sửa và kiểm tra code tại repository owner.
4. Cập nhật spec/status theo kết quả thực tế; commit code và tài liệu tại đúng repository owner.

## Documentation

- [Product vision](specs/product/vision.md) và [glossary](specs/product/glossary.md).
- [UI guidelines](specs/design/ui-guidelines.md).
- [API conventions](specs/api/conventions.md) và [coding conventions](specs/engineering/coding-conventions.md).
- [Architecture decisions](specs/decisions/README.md).

Các feature MVP hiện ở trạng thái draft; acceptance criteria dự thảo không phải bằng chứng đã triển khai hoặc kiểm chứng.
