# AnyRem Workspace

Workspace này chứa feature specification, kiến trúc xuyên repository và hướng dẫn cho agent. Source code vẫn thuộc các Git repository riêng trong `repos/`.

## Setup

```bash
git clone git@github.com:anyrem-org/anyrem-workspace.git
cd anyrem-workspace
./scripts/bootstrap.sh
```

`bootstrap.sh` chỉ clone repository còn thiếu. Script không fetch, reset, pull hoặc sửa repository đã tồn tại.

## Repository Layout

```text
repos/
├── anyrem-desktop/
├── anyrem-be/
├── anyrem-mcp/
└── anyrem-infra/
```

`repos/` bị Git của workspace bỏ qua. Mỗi repository bên trong có remote, branch, commit và pull request riêng.

## Working on a Feature

1. Đọc `AGENTS.md` hoặc `CLAUDE.md`.
2. Đọc `specs/architecture/system-overview.md` và feature specification liên quan.
3. Làm việc, test và commit trong repository owner dưới `repos/`.
4. Commit thay đổi specification hoặc architecture decision trong `anyrem-workspace`.
