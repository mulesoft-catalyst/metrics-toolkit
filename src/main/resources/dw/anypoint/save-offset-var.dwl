%dw 2.0
output application/java
---
if (vars.offset == null) 0 else vars.offset