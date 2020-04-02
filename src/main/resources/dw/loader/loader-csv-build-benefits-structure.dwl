%dw 2.0
import dw::loader::modules::loaderBenefitsBasicStructure
output application/csv
---
loaderBenefitsBasicStructure::main(payload: payload)