%dw 2.0
output application/java

var clientId = attributes.headers."x-anypnt-client-id"
var username = attributes.headers."x-anypnt-username"
---
if (!isEmpty(clientId)) 
  clientId
else 
  username