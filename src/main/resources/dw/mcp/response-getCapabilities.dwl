%dw 2.0
output application/json indent=false
---
{
 "description": "This capability manifest describes the tools (methods) exposed by this agent. Each tool includes a name, description, and an input schema that defines the parameters required to invoke it. Agents can use this manifest to dynamically plan their next actions without hardcoding tool knowledge. The tools listed here follow the JSON-RPC 2.0 specification and must be invoked via POST requests to the MCP endpoint. Agents should first inspect this manifest to determine which tools are available and how to use them, then construct a valid request matching the tool’s input schema.",
 "tools": [ 
  	 {
      "name": "getAvailableCollectors",
      "description": "Returns all collector identifiers supported by the agent.",
      "inputSchema": {
        "type": "object",
        "properties": {}
      }
     },
     {
      "name": "getPlatformMetricsByCollector",
      "description": "Retrieves metrics from a specific Anypoint collector with optional filters",
      "inputSchema": {
        "type": "object",
        "properties": {
          "collectorId": { "type": "string" },
          "bg": { "type": "string" },
          "filters": {
            "type": "object",
            "properties": {
              "environment": { "type": "string" },
              "region": { "type": "string" }
            }
          }
        },
        "required": ["collectorId", "bg"]
      }
    },
    {
      "name": "getPlatformMetricByKey",
      "description": "Fetches a single metric value by key and collector. Useful for atomic, low-latency reads.",
      "inputSchema": {
        "type": "object",
        "properties": {
          "collector": { "type": "string" },
          "metricKey": { "type": "string" },
          "bg": { "type": "string" },
          "environment": { "type": "string" }
        },
        "required": ["collector", "metricKey", "bg"]
      }
    }
  ]
}