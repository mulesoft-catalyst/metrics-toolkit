%dw 2.0
output application/java
---
if (!isEmpty(attributes.headers."X-ANYPNT-CLIENT-ID")) "connected-app-credentials" else "platform-credentials"