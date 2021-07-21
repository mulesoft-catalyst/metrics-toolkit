%dw 2.0
import * from dw::util::Values
output application/java
---
if (aggregatedAPIPayload == null) 
	payload
else 
	(aggregatedAPIPayload update  "assets" with ({([aggregatedAPIPayload.assets,payload.assets])}))
