%dw 2.0
output application/java
---
"query Platform { asset(groupId:\"" ++ payload.groupId ++ "\",assetId:\"" ++ payload.assetId ++ "\",version:\"" ++ payload.version ++ "\") { organizationId, groupId, assetId, version, dependencies { groupId, assetId, version, type } } }"