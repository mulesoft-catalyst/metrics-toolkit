%dw 2.0 
var ignoredOrganizations = Mule::p('secure::ignoreLists.organizations') splitBy ","
output application/json 
--- 
payload filter ((item, index) ->  
    !(ignoredOrganizations contains item.id) 
)
