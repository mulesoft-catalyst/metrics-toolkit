%dw 2.0
output application/json

var reducedOrg = (org) -> {
    id: org.id,
    name: org.name,
    environment: org.environmentsCount,
    parentOrganizations: org.parentOrganizationIds
}

var getOrgAndSubOrgs = (org) -> (
    [reducedOrg(org)] ++ flatten(org.subOrganizations map getOrgAndSubOrgs($))
)

---
getOrgAndSubOrgs(vars.org)