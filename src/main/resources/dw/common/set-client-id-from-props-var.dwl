%dw 2.0
output application/java
---
if (vars.authMode == 'connected-app-credentials') p('secure::auth.clientId') else p('secure::auth.username')