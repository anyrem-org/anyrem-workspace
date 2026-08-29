# AnyRem API Conventions

## Scope

Tài liệu này quy định HTTP API giữa `anyrem-be` và các consumer như desktop hoặc MCP. `anyrem-be` là owner duy nhất của API contract; OpenAPI được generate từ backend tại `/api/docs-json` và không được sửa tay ở repository khác.

## Base URL and Media Type

- Application API dùng prefix `/api`, ví dụ `GET /api/notes`.
- Request và response API dùng JSON với property `camelCase`.
- Route asset công khai như `/avatars` và `/uploads` là ngoại lệ ngoài prefix `/api`; không dùng chúng cho business API mới.

## Resource Design

- Dùng danh từ số nhiều cho resource collection, ví dụ `/notes`, `/categories`, `/inboxes`.
- Dùng `GET` để đọc, `POST` để tạo hoặc thực hiện action không phù hợp với CRUD, `PATCH` để cập nhật một phần và `DELETE` để xoá.
- Action không phải CRUD đặt dưới resource liên quan, ví dụ `POST /notes/:id/open` hoặc `PATCH /notes/:id/pin`.
- Không đưa `userId` vào path, query hoặc request body cho dữ liệu cá nhân; backend lấy user từ access token.

## Authentication and Authorization

- Endpoint dữ liệu người dùng yêu cầu `Authorization: Bearer <token>`.
- Backend phải kiểm tra authorization và giới hạn mọi query theo user đã xác thực.
- Route MCP dưới `/api/mcp/*` dùng token từ identity provider và `McpGuard`; không dùng chúng thay cho auth flow của desktop.
- Endpoint public phải là ngoại lệ rõ ràng và được mô tả trong OpenAPI.

## Requests and Validation

- Request body và query mới phải có DTO ở backend với validation và Swagger metadata.
- Backend transform query value sang kiểu cần thiết; consumer luôn gửi query theo wire format đã ghi trong OpenAPI.
- Không dựa vào property không có trong DTO. Global validation chỉ giữ property được khai báo.
- UUID truyền trong path hoặc query dùng format UUID v4 khi resource yêu cầu UUID.

## Responses

- Response thành công trả trực tiếp resource hoặc result, không bọc trong `data` envelope.
- Collection nhỏ có thể trả array trực tiếp. Collection lớn hoặc có filter/search phải trả pagination object:

```json
{
  "items": [],
  "page": 1,
  "limit": 20,
  "total": 0,
  "totalPages": 0
}
```

- Pagination dùng `page` bắt đầu từ `1` và `limit`; limit mặc định là `20` và không vượt quá `100` cho endpoint hỗ trợ pagination.
- `DELETE` và action endpoint trả shape được định nghĩa bởi OpenAPI; consumer không được tự suy luận response chỉ từ HTTP status.

## Errors

- Giữ HTTP status theo ý nghĩa: `400` cho input hoặc business rule không hợp lệ, `401` cho token thiếu/không hợp lệ, `403` cho truy cập không được phép, `404` cho resource không tồn tại và `409` cho conflict.
- Dùng standard NestJS error response với `statusCode`, `message` và `error`; `message` có thể là string hoặc string array.
- Không trả secret, access token, stack trace, Prisma error hoặc internal service detail cho consumer.

## Data Formats

- Field datetime trả theo ISO 8601 UTC. Date-only value được đưa ra API dùng `YYYY-MM-DD` và phải có timezone diễn giải đi kèm trong contract.
- Không dùng timestamp number khi API chưa quy định rõ; consumer phải theo type trong OpenAPI.
- `BigInt` trong JSON được serialize thành string để tránh mất chính xác.

## Contract Changes

- Thay đổi request, response, auth, quyền, pagination hoặc error behavior là thay đổi API contract.
- Cập nhật implementation và Swagger/OpenAPI trong `anyrem-be` trước, sau đó cập nhật consumer thuộc scope.
- Breaking change cần được ghi trong feature specification hoặc architecture decision liên quan trước khi phát hành.
