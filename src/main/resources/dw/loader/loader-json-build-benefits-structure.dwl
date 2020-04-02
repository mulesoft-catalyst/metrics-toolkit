%dw 2.0
import dw::loader::modules::loaderBenefitsBasicStructure
output application/json
---
loaderBenefitsBasicStructure::main(payload: payload)