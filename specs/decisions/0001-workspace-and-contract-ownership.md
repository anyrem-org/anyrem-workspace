# 0001 — Workspace and API Contract Ownership

Status: accepted

Date: 2026-08-29

## Context

AnyRem gồm các Git repository độc lập: `anyrem-desktop`, `anyrem-be`, `anyrem-mcp`, và `anyrem-infra`. Khi một feature thay đổi nhiều repository, người và agent cần cùng một bản đồ hệ thống, feature specification, và API contract rõ ràng.

## Decision

Tạo `anyrem-workspace` là repository điều phối độc lập. Repository này sở hữu product specifications, kiến trúc xuyên repository, API conventions, engineering conventions, và architecture decisions.

Các repository ứng dụng vẫn giữ Git history, remote, code, và tài liệu kỹ thuật riêng. Chúng được clone vào `repos/` cho local development; thư mục này không được workspace Git theo dõi.

`anyrem-be` là owner duy nhất của HTTP API contract. OpenAPI được generate từ backend và không được định nghĩa hoặc chỉnh sửa thủ công tại desktop, MCP, hoặc workspace. Workspace chỉ tham chiếu tới contract của backend và ghi các quy ước API chung.

## Consequences

- Mỗi feature bắt đầu bằng specification tại `specs/features/`, trước khi sửa code.
- Mỗi chủ đề chỉ có một owner; các nơi khác liên kết tới owner thay vì sao chép nội dung.
- Thay đổi HTTP API bắt đầu tại backend, sau đó OpenAPI và các consumer như desktop/MCP được cập nhật.
- Agent phải bắt đầu từ root `anyrem-workspace`, đọc `AGENTS.md` hoặc `CLAUDE.md`, rồi đọc spec và hướng dẫn của repository cần sửa.
- Thay đổi code vẫn được commit và review trong repository sở hữu code; thay đổi cross-repository spec được commit trong workspace.

## Alternatives Considered

- Monorepo: không chọn vì không cần thay đổi Git history hoặc quy trình phát hành hiện tại chỉ để chia sẻ context.
- Git submodules: không chọn vì manifest + bootstrap clones ít ma sát hơn cho nhu cầu điều phối hiện tại.
- Sao chép OpenAPI vào workspace: không chọn vì tạo thêm một bản có thể bị lệch với backend.
