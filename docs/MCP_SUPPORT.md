## MCP Server Support
---

> **Disclaimer:** MCP Support requires Mule 9.6+.

MCP Server Structure based on the RAML specification of the Metrics Toolkit API. The focus is on **granularity**, **performance**, and **agent-readiness**, breaking down the heavy endpoints into finer-grained, composable tools for MCP Agents.

Complete MCP Spec can be found here. As a high level summary, MCP tools conform to the [JSON-RPC 2.0 specification](https://www.jsonrpc.org/specification).

**NOTE**: The initial implementation of the MCP support will cover the (GET) endpoints of the platform metrics. Benefits and POST endpoints to load data will be added in future.

### Available MCP Server Tools

1. [`getCapabilities`](###getcapabilities)
2. [`getAvailableCollectors`](###getavailablecollectors)
3. [`getPlatformMetricsByCollector`](###getplatformmetricsbycollector)
4. [`getPlatformMetricByKey`](###getplatformmetricbykey)

#### getCapabilities

> **Disclaimer:** This tool may be replaced in future versions by native support for the [Google A2A Protocol](https://github.com/google/a2a/blob/main/spec.md), which standardizes agent capability declarations and execution formats.

| Field                  | Details                                                                                              |
|------------------------|------------------------------------------------------------------------------------------------------|
| Method                 | getAgentCapabilities                                                                                 |
| Type                   | For Agent Discovery Purposes|
| Summary                | Returns a machine-readable summary of the metrics toolkit MCP capabilities, including available tools, parameters, and usage hints. |
| Inputs (`params`)      | None |
| Output (`result`)      | Array of tool metadata objects, each describing one available method and useful info to respond to general FAQ |
| Performance Guidance   | Lightweight. Recommended for initialization, Agent planning (ReAct patterns), or UI rendering of available actions.|
| Agent Use Case | Enables dynamic planning and tool discovery at runtime. Useful for self-configuring or ReAct-style agents. |

###### JSON-RPC Request Example

```json
{
  "jsonrpc": "2.0",
  "id": {uuuid},
  "method": "tools/call",
  "params": {
      "name": "getCapabilities",
      "arguments": {
      }
  }
}
```

###### Response Example

```json
{
  "jsonrpc": "2.0",
  "result": {
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
  },
  "id": {uuuid}
}
```

#### getAvailableCollectors

| Field                  | Details                                                                                             |
|------------------------|------------------------------------------------------------------------------------------------------|
| Method                 | getAvailableCollectors                                                                               |
| Type                   | DiscoveryTool                                                                                        |
| Summary                | Lists all available collector IDs used to retrieve platform metrics.                                 |
| Inputs (`params`)      | None                                                                                                 |
| Output (`result`)      | array<string> of collector identifiers                                                               |
| Performance Guidance   | Lightweight, cacheable, suitable for prefetch or UI support.                                         |
| Agent Use Case         | Agent dynamically determines what collector IDs are supported in the org.                            |

##### JSON-RPC Request Example

```json
POST /mcp
Content-Type: application/json
{
  "jsonrpc": "2.0",
  "method": "tools/call",
  "params": {
      "name": "getAvailableCollectors",
      "arguments": {
      }
  },
  "id": {uuuid},
}
```

##### Response Example

```json
{
	"jsonrpc":"2.0",
	"id": {uuid},
	"result":{
		"content":[
			{
				"type":"text",
				"audience":[],
				"text": "[\"arm\",\"ch\",\"apma\",\"ex\",\"core\",\"dc\",\"rtf\",\"amq\",\"osv2\"]"
			}],
		"isError":false
	}
}
```

#### getPlatformMetricsByCollector

| Field                  | Details                                                                                                                                     |
|------------------------|----------------------------------------------------------------------------------------------------------------------------------------------|
| Method                 | getPlatformMetricsByCollector                                                                                                               |
| Type                   | QueryTool                                                                                                                                   |
| Summary                | Retrieves platform metrics for a specific collector.                                                                                        |
| Inputs (`params`)      | - `collectorId` (string, required). Any of `getAvailableCollectors`|
| Output (`result`)      | JSON result with the collected metrics for the given collector   |
| Performance Guidance   | Require collectorId. Multiple collectors cannot be used to avoid delayed answers to the calling agent |
| Agent Use Cases         | ITops support Agent monitors apps health, licensing Agent to support during renewals |

##### JSON-RPC Request Example

```json
POST /mcp
Content-Type: application/json

{
  "jsonrpc": "2.0",
  "id": {uuid},
  "method": "tools/call",
  "params": {
    "name": "getPlatformMetricsByCollector",
    "arguments": {
      "collector": "ch",
      "bg": {orgId}
    }
  }
}
```

##### Response Example

```json
{
  "jsonrpc": "2.0",
  "id": {uuid},
  "result": {
    "content": [
      {
        "type": "text",
        "audience": [
          
        ],
        "text": "[\n  {\n    \"businessGroup\": \"Fantasy Company\",\n    \"businessGroupId\": \"{orgId}\" ... ]"
      }
    ],
    "isError": false
  }
}
```
#### getPlatformMetricByKey

| Field                  | Details                                                                                          |
|------------------------|---------------------------------------------------------------------------------------------------|
| Method                 | getPlatformMetricByKey                                                                            |
| Type                   | QueryTool                                                                                         |
| Summary                | Fetches a single platform metric value by key. It supports keys containing multiple child keys e.g. networking will return all the networking config for ch collector|
| Inputs (`params`)      | `collector` (string, required), `bg` (string, required), metricKey` (string, required)
| Output (`result`)      | JSON response with metric value |
| Performance Guidance   | Optimized for low-latency, atomic metric retrieval.                                               |
| Agent Use Case         | Alerting agent reads one key for rapid decision making.                                           |

##### JSON-RPC Request Example

```json
{
  "jsonrpc": "2.0",
  "id": {uuid},
  "method": "tools/call",
  "params": {
    "name": "getPlatformMetricsByKey",
    "arguments": {
      "collector": "ch",
      "bg": {orgId},
      "metricKey": "networking"
    }
  }
}
```

##### Response Example

```json
{
	"jsonrpc":"2.0",
	"id": {uuid},
	"result":{
		"content":[
			{
				"type":"text",
				"audience":[],
				"text": "[{\"businessGroup\": ... "
			}],
		"isError":false
	}
}
```