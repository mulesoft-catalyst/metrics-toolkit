%dw 2.0
output application/java
---
if (!isEmpty(attributes.headers."X-ANYPNT-CLIENT-ID")) 
  attributes.headers."X-ANYPNT-CLIENT-ID" 
else 
  attributes.headers."X-ANYPNT-USERNAME"