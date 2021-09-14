%dw 2.0
output application/json
---
{
	message: "Bad request",
	error: error.description default ""
}
