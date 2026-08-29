# Architecture Decisions

## Purpose

`specs/decisions/` lưu Architecture Decision Records (ADR): các quyết định kiến trúc đã được con người chốt. ADR giải thích quyết định nào đang áp dụng, lý do chọn nó và các lựa chọn đã loại, để người và agent không lặp lại tranh luận cũ hoặc tự đổi nguyên tắc hệ thống.

## When to Create

Tạo ADR khi quyết định ảnh hưởng nhiều repository hoặc nhiều feature, có trade-off đáng kể, khó đảo ngược, hoặc cần làm rõ ownership, authentication, API contract, data flow, infrastructure hay cách chia sẻ code.

## When Not to Create

Không tạo ADR cho implementation cục bộ, convention format/naming, bug, tiến độ feature, API field thông thường hoặc hướng dẫn setup.

## Lifecycle

- Agent có thể soạn draft ADR khi cần, nhưng con người quyết định nội dung và chuyển `Status` thành `accepted`.
- ADR đã `accepted` không bị sửa để thay đổi quyết định cũ. Quyết định mới tạo ADR mới và ghi rõ ADR nào bị thay thế.
- Status dùng `proposed`, `accepted` hoặc `superseded`.

## Format

Tên file dùng dạng `NNNN-<slug>.md`, bắt đầu từ `0001`. Mỗi ADR có title, `Status`, `Date`, cùng các heading `Context`, `Decision`, `Consequences` và `Alternatives Considered`.
