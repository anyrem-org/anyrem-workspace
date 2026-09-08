# Search

## Goal

Giúp người dùng tìm lại note nhanh bằng từ khoá, filter và lịch sử tìm kiếm.

## Scope

- `anyrem-desktop`: Search Home, result preview, filter, clear search history, toggle `showInGlobalSearch` trên note/category.
- `anyrem-be`: search API, history persistence, user filter, search index integration và global search visibility.

## Behavior

- Search trả note phù hợp theo relevance hoặc recent sort.
- Người dùng có thể filter theo category, pinned state và khoảng ngày.
- Từ khoá tìm kiếm có thể được lưu trong search history và người dùng có thể xoá history.
- Result dẫn tới preview hoặc full note mà không làm lộ note của user khác.
- User có thể tắt `showInGlobalSearch` ở category hoặc note để ẩn khỏi **global search** (Search Home, Quick Search, `GET /notes?q=` không có `categoryId`, MCP search).
- Category tắt `showInGlobalSearch` → mọi note trong category không xuất hiện trong global search.
- Note thuộc nhiều category: chỉ cần một category tắt `showInGlobalSearch` → note ẩn khỏi global search.
- **In-category search** (`GET /categories/:id/notes?q=`, `GET /notes?categoryId=...&q=`): vẫn tìm được note dù `showInGlobalSearch=false`.
- `GET /search/notes?categoryId=...` (Search Home filter category) vẫn là global strict — note ẩn không trả về.
- Duyệt list không có `q` vẫn thấy note bình thường.

## Acceptance Criteria

- Query và filter trả pagination đúng theo API contract.
- Search history chỉ thuộc user đang đăng nhập.
- Clear history không xoá note hoặc dữ liệu search của user khác.
- Note/category `showInGlobalSearch=false` không trả về trong global keyword search.
- Search trong category vẫn trả note dù `showInGlobalSearch=false`.
- Bật lại `showInGlobalSearch=true` → note xuất hiện trong global search sau reindex (vài giây).
- Category toggle ảnh hưởng tất cả note liên quan trong global search.
