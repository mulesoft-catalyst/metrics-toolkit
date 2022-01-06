%dw 2.0
output application/json
var ignoredEnvironments = Mule::p('secure::ignoreLists.environments') splitBy ","
var filteredEnvironments = payload.data filter ((item, index) -> !(ignoredEnvironments contains item.id))
---

{
	"data": filteredEnvironments,
	"total": sizeOf(filteredEnvironments)
}