output json indent=false
---
payload map ((item, index) -> 
    {
        "date": item.date,
        "businessGroup": item.businessGroup,
        "businessGroupId": item.businessGroupId,
        (mqMetrics: item.mqMetrics) if(vars.rpcCollector == "amq"),
        (apiManagerMetrics: item.apiManagerMetrics) if(vars.rpcCollector == "apm"),
        (apiManagerMetrics: { clients: item.apiManagerMetrics.clients}) if(vars.rpcCollector == "apc"),
        (runtimeManagerMetrics: item.runtimeManagerMetrics) if(vars.rpcCollector == "arm"),
        (runtimeManagerMetrics: { cloudhub: item.runtimeManagerMetrics.cloudhub }) if(vars.rpcCollector == "ch"),
        (coreServicesMetrics: item.coreServicesMetrics) if(vars.rpcCollector == "core"),
        (designCenterMetrics: item.designCenterMetrics) if(vars.rpcCollector == "dc"),
        (exchangeMetrics: item.exchangeMetrics) if(vars.rpcCollector == "ex"),
        (osV2Metrics: item.osV2Metrics) if(vars.rpcCollector == "osv2"),
        (rtf: item.rtf) if(vars.rpcCollector == "rtf"),
        (notImplemented: "Collector Not Implemented") if(vars.rpcCollector == "ap"),
        (notImplemented: "Collector Not Implemented") if(vars.rpcCollector == "apma")
    })