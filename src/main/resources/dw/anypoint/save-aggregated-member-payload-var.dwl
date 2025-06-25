%dw 2.0
import * from dw::util::Values
output application/java
---
if (vars.aggregatedMemberPayload == null) payload
else (vars.aggregatedMemberPayload update  "data" with (vars.aggregatedMemberPayload.data ++ payload.data))
