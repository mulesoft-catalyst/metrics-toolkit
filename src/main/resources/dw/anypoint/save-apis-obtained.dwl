%dw 2.0
output application/java
---
if (vars.apisTotalObtained == null) 
(sizeOf(payload.assets))
else 
(vars.apisTotalObtained + (sizeOf(payload.assets)))