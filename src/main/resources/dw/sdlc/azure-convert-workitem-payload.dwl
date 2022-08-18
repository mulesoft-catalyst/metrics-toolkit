%dw 2.0
output application/json
---
payload.value map() -> {
    id: $.id,
    name: $.fields."System.Title",
    taskType: $.fields."System.WorkItemType",
    status: $.fields."System.State"
}