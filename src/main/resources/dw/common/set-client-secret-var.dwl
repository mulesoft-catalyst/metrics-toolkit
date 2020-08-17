%dw 2.0
output application/java
---
if (!isEmpty(attributes.headers."X-ANYPNT-CLIENT-SECRET")) 
  attributes.headers."X-ANYPNT-CLIENT-SECRET" 
else attributes.headers."X-ANYPNT-PASSWORD"