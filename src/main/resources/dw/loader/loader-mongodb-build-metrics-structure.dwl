%dw 2.0
import dw::loader::modules::loaderMetricsBasicStructure
output application/json
---
loaderMetricsBasicStructure::main(payload: payload)