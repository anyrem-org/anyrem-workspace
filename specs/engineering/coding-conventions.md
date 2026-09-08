# Soonio Coding Conventions

## Scope and Document Priority

Áp dụng cho bốn repository Soonio. Sau system overview, đọc feature specification, ADR liên quan, tài liệu này và hướng dẫn cục bộ của repository owner. Với UI, đọc [UI guidelines](../design/ui-guidelines.md). Nếu có mâu thuẫn ảnh hưởng behavior hoặc kiến trúc, báo rõ và làm rõ trước phần implementation phụ thuộc nó; chỉ dẫn trực tiếp đã được user chốt là căn cứ của phạm vi công việc.

Workspace sở hữu spec và ADR; repository code sở hữu implementation, technical docs và tests. API contract thuộc Laravel backend. Liên kết tới nguồn owner thay vì sao chép.

## Frontend Stack and Responsibilities

| Tool | Responsibility |
| --- | --- |
| React + TypeScript strict | UI và type safety cho web/extension/shared. |
| Vite | Tooling/build cho React SPA; extension theo entrypoints và tooling WXT. |
| Mantine | UI components và theme. |
| React Router | Routing phía client khi có navigation trong ứng dụng. |
| TanStack Query | Server state, API cache, query và mutation lifecycle. |
| Axios | HTTP qua instance tập trung của client. |
| React Hook Form | Form state và interactions. |
| Zod | Validation phía client cho trải nghiệm form. |
| Zustand | Local/global UI state cần chia sẻ. |
| Luxon | Date/time/timezone phía client. |
| Lucide React | Icons. |

Không duplicate server state vào Zustand. Không đặt business logic quan trọng như effective reminders hoặc tính kỳ gia hạn trong React; backend quyết định. Client validation không thay backend validation. Không gọi axios rải rác; feature API module sử dụng instance chung trong client.

## Frontend Structure

Cấu trúc theo feature, tham khảo cách tổ chức renderer AnyRem; không kế thừa implementation hay dependency UI của sản phẩm đó.

```text
soonio-web/src/
  app/                  # Khởi tạo, providers, routing
  layouts/              # Layout riêng của web
  features/<feature>/
    api/                # Gọi API qua instance chung
    components/         # Component thuộc feature
    hooks/              # Query/mutation hooks và behavior UI
    pages/
    schemas/            # Zod schemas phục vụ form
    types/
    store/              # UI state khi có nhu cầu
  shared/
    lib/                # Axios instance, tích hợp riêng client
    store/              # UI state chung trong client
    types/

soonio-extension/src/
  entrypoints/          # Entry points theo WXT
  app/
  layouts/
  features/<feature>/   # Cùng cách chia như web
  shared/

soonio-shared/src/
  components/           # UI tổng hợp tái sử dụng
  primitives/           # Primitive tùy biến có use case rõ ràng
  theme/                # Mantine theme và design tokens
  index.ts              # Public exports
```

Chỉ tạo thư mục khi có code tương ứng. Cấu hình source directory cụ thể của WXT được thiết lập tại repository extension khi scaffold; đây là layout mục tiêu, không khẳng định đã có cấu hình đó.

## Shared UI Boundaries

- UI component/primitive dùng chung thuộc `soonio-shared`; component gắn với feature/platform cụ thể thuộc client.
- Shared nhận dữ liệu/callback qua props; không phụ thuộc API client, router, store của ứng dụng hoặc Chrome/Electron API.
- Client import qua public exports; shared không import ngược từ client. Không deep import implementation nội bộ.
- Dùng trực tiếp Mantine nếu đã đáp ứng; không tạo wrapper chỉ đổi tên, không mang Radix/CVA hoặc CSS stack của reference sang Soonio.
- Không thêm abstraction, dependency hay configuration nếu chưa có use case rõ ràng. Cách phân phối/version package shared được chốt khi tích hợp thực tế.

## Backend

Laravel là source of truth: validation, authorization theo user, persistence, business rules và reminders thuộc `soonio-api`. Framework conventions, formatter, cấu trúc PHP và lệnh chạy/test tuân theo hướng dẫn cục bộ repository. Không kế thừa quy định NestJS/Prisma; wire format theo [API conventions](../api/conventions.md) sau khi được chốt.

## Security and Code Hygiene

- Không hardcode hoặc commit secret/token/password/private key; không commit `.env`. File example phải được làm sạch secret.
- Không dùng mock data cho luồng production khi backend thật thuộc scope.
- Naming rõ nghĩa, comment giải thích intent/constraint; ưu tiên solution đơn giản và dễ maintain.
- Chạy formatter/check theo repository owner; không thêm công cụ format chỉ cho một thay đổi.
- Mọi text file kết thúc bằng đúng một newline, không thêm dòng trống ở EOF.

## Documentation Notice

- Trước khi tạo, sửa hoặc xóa tài liệu, thông báo `Docs: <relative-path> — <lý do>` trong cập nhật tiến độ.
- Liệt kê từng path và lý do khi nhiều file thay đổi; không gộp chung chung.
- Bàn giao xác nhận các file tài liệu đã cập nhật. Không cần notice nếu không thay đổi tài liệu.

## Changes and Validation

Chỉ sửa repository và behavior trong scope. Chạy typecheck/test/build phù hợp với code đã đổi; docs-only kiểm tra liên kết, tính nhất quán và diff. Bug fix cần expected behavior và regression check phù hợp. Cập nhật spec khi behavior đổi, ADR khi kiến trúc/ownership đổi và status khi có bằng chứng mới. Commit code tại repository owner, spec/ADR tại workspace; không tự commit khi chưa được yêu cầu.

## API Data and Actions

Theo [ADR 0003](../decisions/0003-api-data-and-actions.md), dùng Spatie Laravel Data với Create/Update/Response Data riêng và Action PHP inject theo nghiệp vụ. Đặt trong `app/Domain/<Domain>/Data` và `Actions` khi có code; Models/Policies giữ convention Laravel. Không dùng ViewModel, BaseViewModel reflection hoặc mặc định upsert mọi CRUD.

Data sở hữu cấu trúc/validation input; Action sở hữu nghiệp vụ/transaction và kiểm tra owner của quan hệ tham chiếu. Controller xử lý HTTP/authorization. Không truyền Request vào Action hoặc tin user_id/ID cập nhật từ body. PATCH giữ phân biệt missing/null; không mass assign toàn bộ DTO. Query class chỉ thêm khi query phức tạp. Không duplicate validation với FormRequest; dữ liệu ngoài HTTP phải validate tường minh.

## Agent quality checks

- Dùng dependency local và lockfile; không dùng formatter từ project khác hoặc tự nâng dependency ngoài scope.
- Web/shared: trong `repos/soonio-web`, dùng Node theo `.nvmrc`, `pnpm install --frozen-lockfile`, rồi `pnpm check`. Lệnh này chạy ESLint, Prettier check, TypeScript, tests và build.
- API: trong `repos/soonio-api`, dùng `composer install`, rồi `composer check` (Pint, Larastan, PHPUnit). PHP CLI cần mbstring, pdo_pgsql và pdo_sqlite cho test suite hiện tại.
- Khi sửa code, format file trong scope và chạy regression test phù hợp. Không tắt rule, thêm baseline hoặc bỏ test chỉ để check xanh. Báo rõ lỗi tồn tại sẵn và kiểm tra bị môi trường chặn.
- Không coi build thành công là đã kiểm tra UI trên browser. Giữ thay đổi của user; không mass-format file ngoài scope.

ESLint dùng recommended JavaScript/TypeScript và rules-of-hooks/exhaustive-deps. Prettier sở hữu formatting frontend; Pint sở hữu PHP. Larastan bắt đầu level 5, không có baseline bỏ qua lỗi cũ.

TypeScript compiler giữ bản 7 qua alias `@typescript/native`; `typescript` trỏ tới `@typescript/typescript6` để cung cấp API cho typescript-eslint. Không xóa alias trước khi xác minh linter hỗ trợ API mới.
