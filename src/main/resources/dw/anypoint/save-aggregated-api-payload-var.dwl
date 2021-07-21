%dw 2.0
import * from dw::util::Values
output application/java
---
if (vars.aggregatedAPIPayload == null) 
	payload
else 
	(vars.aggregatedAPIPayload update  "assets" with ({([vars.aggregatedAPIPayload.assets,payload.assets])}))
