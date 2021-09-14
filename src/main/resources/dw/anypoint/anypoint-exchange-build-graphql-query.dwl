%dw 2.0
output application/java
---
"query Platform { assets(organizationIds: [\"" ++ vars.orgId ++ "\"], types: [\"rest-api\", \"raml-fragment\", \"http-api\", \"soap-api\", \"policy\", \"connector\", \"extension\", \"app\", \"custom\"], latestVersionsOnly: true, limit:" ++ vars.limit ++ ", offset: " ++ vars.offset ++" ) { organizationId, groupId, assetId, version, minorVersion, versionGroup, description, name, type, status, isPublic, isLatestVersion, createdDate, updatedDate, originalFormat, minMuleVersion, isGenerated, isMozartTemplate, isSnapshot, rating, numberOfRates } }"