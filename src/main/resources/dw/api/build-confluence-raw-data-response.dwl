%dw 2.0
output application/json
---
payload mapObject {
	($$) : $
} - "results" - "_links" - "size" ++ 
 {
	"size" : sizeOf(vars.outputPayload default[])
} ++ {
	"results" : vars.outputPayload
}