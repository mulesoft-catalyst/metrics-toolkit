%dw 2.0
output application/java

var mappings = [
  {
    sourceField: "collector",
    targetField: "collectors",
    targetType: "queryParams"
  },
  {
    sourceField: "bg",
    targetField: "x-anypnt-org-id",
    targetType: "headers"
  },
  {
  	sourceField: "raw",
    targetField: "raw",
    targetType: "queryParams"
  }
]

fun buildMapFor(targetType: String) =
  (
    ((mappings filter (m) -> m.targetType == targetType) filter (m) -> payload[m.sourceField] != null)
      map (m) -> {
        (m.targetField): payload[m.sourceField]
      }
  )
  reduce (acc = {}, item) -> acc ++ item

---
{
    headers: attributes.additionalProperties default {} ++ buildMapFor("headers"),
    queryParams: attributes.queryParams default {} ++ buildMapFor("queryParams")
}
