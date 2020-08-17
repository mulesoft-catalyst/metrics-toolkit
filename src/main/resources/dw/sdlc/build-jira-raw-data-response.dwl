%dw 2.0
output application/json
---
payload mapObject {
	($$) : $
} - "issues" ++ {
	"issues" : vars.outputPayload
}