%dw 2.0
output application/java
---
if (vars.membersTotalObtained == null) 
(sizeOf(payload.data))
else 
(vars.membersTotalObtained + (sizeOf(payload.data)))