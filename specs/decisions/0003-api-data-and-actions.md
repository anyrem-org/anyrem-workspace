# 0003 — API Data and Actions

Status: accepted

Date: 2026-09-05

## Context

User chốt Spatie Laravel Data + Actions cho Soonio API, không dùng ViewModel. Laravel tiếp tục sở hữu contract và business logic theo ADR 0002.

## Decision

- Dùng spatie/laravel-data cho input/output DTO; tách Create, Update và Response Data theo use case.
- Actions là class PHP được inject, không cần package actions. Tách Create/Update; không mặc định upsert dựa trên ID trong body.
- Tổ chức app/Domain/<Domain>/Data và Actions; chỉ tạo khi có implementation. Models và Policies giữ ở app/Models và app/Policies; controller ở app/Http/Controllers.
- Controller điều phối HTTP và authorization. Data validate cấu trúc input; Action xử lý nghiệp vụ, transaction và mapping persistence rõ ràng.
- PATCH phân biệt field thiếu và null. User xác thực truyền riêng; kiểm tra ownership resource và group tham chiếu.
- Không đặt truy vấn relationships hoặc business logic trong DTO factory. Không duplicate rules giữa Data và FormRequest; đầu vào ngoài HTTP cần validation tường minh.
- Không dùng ViewModel hoặc BaseViewModel reflection. Query class chỉ thêm cho truy vấn phức tạp; Response Data định nghĩa output.
- Không thêm Repository, BaseService hoặc framework DDD khi chưa có nhu cầu.

## Consequences

Action có thể dùng từ HTTP/job/command mà không phụ thuộc Request. Spatie trở thành dependency API; contract auth, wire format, pagination, OpenAPI và reminder scheduling vẫn cần chốt riêng. Quyết định này không triển khai endpoints hoặc migrations.

## Alternatives Considered

- Một DTO và Upsert dùng chung mọi thao tác: không phù hợp PATCH và ranh giới quyền.
- ViewModel theo màn hình Inertia: không cần cho REST API hiện tại.
- DTO PHP thuần: khả thi nhưng user chọn Spatie để hỗ trợ validation và transformation.
