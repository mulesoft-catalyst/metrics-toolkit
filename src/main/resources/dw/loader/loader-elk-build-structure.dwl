%dw 2.0
output application/x-ndjson
---
flatten(payload map ((v,k) -> 
	[{index: {}}] ++ 
	[{ (v) }]
	)
)