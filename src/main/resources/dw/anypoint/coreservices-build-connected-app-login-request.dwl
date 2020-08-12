%dw 2.0
output application/x-www-form-urlencoded
---
{
	grant_type: "client_credentials", 
	client_id: vars.clientId,
	client_secret: vars.clientSecret
}