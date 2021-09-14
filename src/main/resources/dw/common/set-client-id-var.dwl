%dw 2.0
output application/java

var clientId = attributes.headers."X-ANYPNT-CLIENT-ID"
var username = attributes.headers."X-ANYPNT-USERNAME"
---
if (!isEmpty(clientId)) 
  clientId
else 
  username