%dw 2.0
output application/json
---
vars.aggData default [] ++ 

if (payload.count == 0) 
    [{"result":"no runs"}] 
else 
    [(((payload.value map() -> {
        name: $.pipeline.name,
        state: $.state,
        result: $.result,
        createdDate: $.createdDate as LocalDateTime,
}) orderBy $.createdDate)[-1 to 0])[0]]