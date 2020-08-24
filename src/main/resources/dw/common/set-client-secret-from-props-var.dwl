%dw 2.0
output application/java
---
if (vars.authMode == 'connected-app-credentials') p('secure::auth.clientSecret') else p('secure::auth.password')