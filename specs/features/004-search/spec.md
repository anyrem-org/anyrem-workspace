# Search

## Goal

Giúp người dùng tìm lại note nhanh bằng từ khoá, filter và lịch sử tìm kiếm.

## Scope

- `anyrem-desktop`: Search Home, result preview, filter và clear search history.
- `anyrem-be`: search API, history persistence, user filter và search index integration.

## Behavior

- Search trả note phù hợp theo relevance hoặc recent sort.
- Người dùng có thể filter theo category, pinned state và khoảng ngày.
- Từ khoá tìm kiếm có thể được lưu trong search history và người dùng có thể xoá history.
- Result dẫn tới preview hoặc full note mà không làm lộ note của user khác.

## Acceptance Criteria

- Query và filter trả pagination đúng theo API contract.
- Search history chỉ thuộc user đang đăng nhập.
- Clear history không xoá note hoặc dữ liệu search của user khác.
