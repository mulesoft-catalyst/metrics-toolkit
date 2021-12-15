%dw 2.0
output application/java
---
if (!isEmpty(attributes.headers."x-anypnt-client-id")) "connected-app-credentials" else "platform-credentials"