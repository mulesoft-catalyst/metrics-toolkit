%dw 2.0
output application/json

var reducedOrg = (org) -> {
    id: org.id,
    name: org.name,
    entitlements: org.entitlements
}

var getOrgAndSubOrgs = (payload) -> (
    [reducedOrg(payload)] ++ flatten(payload.subOrganizations map getOrgAndSubOrgs($))
)

var ignoredOrganizations = Mule::p('secure::ignoreLists.organizations') splitBy ","
---
getOrgAndSubOrgs(payload) filter ((item, index) ->  
    !(ignoredOrganizations contains item.id) 
)