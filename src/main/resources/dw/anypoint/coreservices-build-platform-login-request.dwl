%dw 2.0
output application/json
---
{
	username: vars.clientId,
	password: vars.clientSecret
}