%dw 2.0
import * from dw::core::Binaries
output application/java
---
(fromBase64((attributes.headers.Authorization default "") replace "Basic " with "") as String splitBy ":")[0]