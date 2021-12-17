%dw 2.0
output application/json
---
{
    size: payload.count,
    repositories: (payload.value filter not $.isDisabled) map() -> {name: $.name}
}
