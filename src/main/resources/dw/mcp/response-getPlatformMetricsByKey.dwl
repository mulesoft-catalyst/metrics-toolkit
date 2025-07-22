%dw 2.0
output application/json indent=false

fun filterTree(obj) =
  if (obj is Object) do {
    var children = 
      obj
      mapObject ((value, key) -> (key): filterTree(value))
      filterObject ((value, key) -> !(isEmpty(value) or value == null))
    var includeSelf = (obj[vars.rpcMetricKey] default null) != null
    ---
    if (!isEmpty(children) or includeSelf)
      (if (includeSelf) children ++ {(vars.rpcMetricKey): obj[vars.rpcMetricKey]} else children)
    else null
  }
  else if (obj is Array) do {
    var filtered = obj map (item) -> filterTree(item)
    var nonEmpty = filtered filter (item) -> !(isEmpty(item) or item == null)
    ---
    if (!isEmpty(nonEmpty)) nonEmpty else null
  }
  else null

---
payload map (item) -> {
  businessGroup: item.businessGroup,
  businessGroupId: item.businessGroupId,
  (runtimeManagerMetrics: filterTree(item.runtimeManagerMetrics)) if(vars.rpcCollector == "arm"),
  (cloudhub: filterTree(item.runtimeManagerMetrics.cloudhub)) if(vars.rpcCollector == "ch"),
  (mqMetrics: filterTree(item.mqMetrics)) if(vars.rpcCollector == "amq"),
  (apiManagerMetrics: filterTree(item.apiManagerMetrics)) if(vars.rpcCollector == "apm"),
  (clients: filterTree(item.apiManagerMetrics.clients)) if(vars.rpcCollector == "apc"),
  (coreServicesMetrics: filterTree(item.coreServicesMetrics)) if(vars.rpcCollector == "core"),
  (designCenterMetrics: filterTree(item.designCenterMetrics)) if(vars.rpcCollector == "dc"),
  (exchangeMetrics: filterTree(item.exchangeMetrics)) if(vars.rpcCollector == "ex"),
  (osV2Metrics: filterTree(item.osV2Metrics)) if(vars.rpcCollector == "osv2"),
  (rtf: filterTree(item.rtf)) if(vars.rpcCollector == "rtf")
}
