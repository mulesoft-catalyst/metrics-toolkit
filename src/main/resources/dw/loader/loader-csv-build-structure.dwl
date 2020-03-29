%dw 2.0
import dw::loader::modules::loaderMetricsBasicStructure
output application/csv
---
loaderMetricsBasicStructure::main(payload: payload)