%dw 2.0
output application/json
---
(payload.subOrganizations map {  //recursive of subOrganizations ".." descendants selector not working
	id: $.id,
	name: $.name,
	entitlements: $.entitlements 
}) + { //masterOrg
	id: payload.id,
	name: payload.name,
	entitlements: payload.entitlements
}