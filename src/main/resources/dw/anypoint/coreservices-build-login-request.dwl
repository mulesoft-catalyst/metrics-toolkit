%dw 2.0
output application/json
---
{
	username: p('anypoint.platform.username'),
	password: p('anypoint.platform.password')
}