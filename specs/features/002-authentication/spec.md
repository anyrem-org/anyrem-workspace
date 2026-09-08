# Authentication

## Goal

Cho phép người dùng tạo tài khoản, đăng nhập và khôi phục session an toàn trong desktop app.

## Scope

- `anyrem-desktop`: login, register, quên mật khẩu, Google sign-in, session bootstrap và logout.
- `anyrem-be`: auth, email verification, refresh token và user profile API.

## Behavior

- Người dùng có thể đăng ký, nhận yêu cầu xác thực email và gửi lại email xác thực.
- Người dùng có thể đăng nhập bằng email/password hoặc Google qua system browser và deep link `anyrem://`.
- Access token dùng cho API request; refresh token được lưu qua Electron bridge và dùng để khôi phục session.
- Logout hoặc refresh thất bại xoá refresh token và session cục bộ.

## Acceptance Criteria

- Người dùng đã xác thực có thể vào protected route sau login hoặc session restore.
- Token không được lưu trực tiếp trong renderer local storage.
- Login, logout và Google callback không làm lộ token cho UI không được phép.
