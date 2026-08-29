# AnyRem Coding Conventions

## Scope

Tài liệu này quy định nguyên tắc chung cho mọi repository của AnyRem. Quy tắc về framework, cấu trúc thư mục, định dạng code, naming và lệnh kiểm tra cụ thể thuộc `AGENTS.md` của repository sở hữu code.

## Document Priority

Trước khi sửa code, đọc tài liệu theo thứ tự sau:

1. Feature specification liên quan trong `specs/features/`.
2. Architecture decision liên quan trong `specs/decisions/`.
3. Tài liệu này.
4. `AGENTS.md` của repository cần sửa.

Khi các tài liệu mâu thuẫn, feature specification và architecture decision đã được chấp nhận có ưu tiên cao hơn nhưng hãy hiện warning để dev biết để confirm; sau đó tuân theo hướng dẫn cục bộ của repository owner.

## Ownership

- Product behavior, feature specification và kiến trúc xuyên repository thuộc `anyrem-workspace`.
- Code, technical documentation, test và cấu hình runtime thuộc repository sở hữu code.
- HTTP API wire contract thuộc `anyrem-be`; OpenAPI phải được generate từ backend.
- Không sao chép specification hoặc API contract sang repository khác. Hãy liên kết đến nguồn owner.

## Security and Dependencies

- Không hardcode secret, token, mật khẩu hoặc private key.
- Không commit `.env` hoặc file chứa secret; chỉ commit file `.example` đã được làm sạch secret.
- Không thêm dependency, abstraction hoặc configuration mới nếu code, platform hoặc dependency hiện có đã đáp ứng nhu cầu.
- Không dùng mock data cho luồng production khi backend/API thật đã thuộc scope.

## Documentation Notice

- Trước khi tạo hoặc sửa tài liệu, agent phải thông báo rõ `Docs: <relative-path> — <lý do>` trong cập nhật tiến độ.
- Khi nhiều tài liệu thay đổi, liệt kê từng path và lý do; không gộp thành thông báo chung chung.
- Sau khi hoàn tất, câu trả lời bàn giao phải xác nhận các file tài liệu đã cập nhật.
- Không cần thông báo này khi không có thay đổi tài liệu.

## Changes and Validation

- Chỉ sửa repository thật sự thuộc scope của feature; tránh refactor không liên quan.
- Chạy typecheck, test và build phù hợp với repository đã sửa trước khi bàn giao.
- Với bug fix, đối chiếu expected behavior trước, truy vết root cause và thêm regression check nhỏ nhất phù hợp.
- Agent chủ động cập nhật tài liệu owner khi thay đổi đã được xác minh và không cần quyết định product hoặc architecture mới.
- Cập nhật feature specification khi behavior hoặc acceptance criteria thay đổi.
- Tạo hoặc cập nhật architecture decision khi thay đổi kiến trúc, ownership hoặc nguyên tắc áp dụng cho nhiều feature/repository.
- Commit code tại repository owner; commit feature specification và architecture decision tại `anyrem-workspace`.
