# Avatars

## Goal

Cho phép người dùng chọn avatar từ catalog có sẵn để cá nhân hoá profile.

## Scope

- `anyrem-desktop`: avatar picker, style tab và hiển thị avatar asset.
- `anyrem-be`: avatar style/catalog API và cập nhật avatar của user.

## Behavior

- Người dùng duyệt avatar theo style và chọn một avatar hợp lệ.
- Backend chỉ chấp nhận avatar có trong catalog.
- Asset avatar được phục vụ qua public asset URL; profile chỉ lưu reference avatar đã chọn.

## Acceptance Criteria

- Chọn avatar cập nhật profile của user hiện tại.
- Avatar ID không hợp lệ bị backend từ chối.
- UI có fallback khi style hoặc avatar list rỗng.
