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
---
getOrgAndSubOrgs(payload)