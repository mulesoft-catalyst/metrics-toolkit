## MCP Server Support
---

MCP Server Structure based on the RAML specification of the Metrics Toolkit API. The focus is on **granularity**, **performance**, and **agent-readiness**, breaking down the heavy endpoints into finer-grained, composable tools for MCP Agents.

Complete MCP Spec can be found here. As a high level summary, MCP tools conform to the [JSON-RPC 2.0 specification](https://www.jsonrpc.org/specification).

**NOTE**: The initial implementation of the MCP support will cover the (GET) endpoints of the platform metrics. Benefits and POST endpoints to load data will be added in future.

### Available MCP Server Tools

1. [`getAgentCapabilities`](###getagentcapabilities)
2. [`getAvailableCollectors`](###getavailablecollectors)
3. [`getPlatformMetricsByCollector`](###getplatformmetricsbycollector)
4. [`getPlatformMetricByKey`](###getplatformmetricbykey)

### getAgentCapabilities

> **Disclaimer:** This tool may be replaced in future versions by native support for the [Google A2A Protocol](https://github.com/google/a2a/blob/main/spec.md), which standardizes agent capability declarations and execution formats.

| Field                  | Details                                                                                              |
|------------------------|------------------------------------------------------------------------------------------------------|
| Method                 | getAgentCapabilities                                                                                 |
| Type                   | For Agent Discovery Purposes|
| Summary                | Returns a machine-readable summary of the metrics toolkit capabilities, including available tools, parameters, and usage hints. |
| Inputs (`params`)      | None |
| Output (`result`)      | Array of tool metadata objects, each describing one available method and useful info to responde to general FAQ |
| Performance Guidance   | Lightweight. Recommended for initialization, Agent planning (ReAct patterns), or UI rendering of available actions.|
| Agent Use Case | Enables dynamic planning and tool discovery at runtime. Useful for self-configuring or ReAct-style agents. |

#### JSON-RPC Request Example

```json
{
  "jsonrpc": "2.0",
  "method": "getAgentCapabilities",
  "params": {},
  "id": {uuuid}
}
```

#### Response Example

```json
{
  "jsonrpc": "2.0",
  "result": [
    "information": "The content under tools dictates the available tools that can be invoked while interacting with this API...",
    "tools": [
    {
      "name": "getPlatformMetricsByCollector",
      "description": "Retrieves metrics from a specific collector ...",
      "type": "QueryTool",
      "params": [{"id": "collectorId", "type": "queryParam", "dataType": "string"}],
      "performanceHint": "Requires filtering by collectorId..."
    },
   ...
   ]
  ],
  "id": {uuuid}
}
```

### getAvailableCollectors

| Field                  | Details                                                                                             |
|------------------------|------------------------------------------------------------------------------------------------------|
| Method                 | getAvailableCollectors                                                                               |
| Type                   | DiscoveryTool                                                                                        |
| Summary                | Lists all available collector IDs used to retrieve platform metrics.                                 |
| Inputs (`params`)      | None                                                                                                 |
| Output (`result`)      | array<string> of collector identifiers                                                               |
| Performance Guidance   | Lightweight, cacheable, suitable for prefetch or UI support.                                         |
| Agent Use Case         | Agent dynamically determines what collector IDs are supported in the org.                            |

#### JSON-RPC Request Example

```json
POST /mcp
Content-Type: application/json
{
  "jsonrpc": "2.0",
  "method": "getAvailableCollectors",
  "params": {},
  "id": "4"
}
```

#### Response Example

```json
{
  "jsonrpc": "2.0",
  "result": [
    "arm",
    "ch",
    "apma",
    "ex",
    "core",
    "dc",
    "rtf",
    "amq",
    "osv2"
  ],
  "id": "4"
}
```

### getPlatformMetricsByCollector

| Field                  | Details                                                                                                                                     |
|------------------------|----------------------------------------------------------------------------------------------------------------------------------------------|
| Method                 | getPlatformMetricsByCollector                                                                                                               |
| Type                   | QueryTool                                                                                                                                   |
| Summary                | Retrieves platform metrics for a specific collector.                                                                                        |
| Inputs (`params`)      | - `collectorId` (string, required). Any of `getAvailableCollectors`|
| Output (`result`)      | JSON result with the collected metrics for the given collector   |
| Performance Guidance   | Require collectorId. Multiple collectors cannot be used to avoid delayed answers to the calling agent |
| Agent Use Cases         | ITops support Agent monitors apps health, licensing Agent to support during renewals |

#### JSON-RPC Request Example

```json
POST /mcp
Content-Type: application/json

{
  "jsonrpc": "2.0",
  "method": "getPlatformMetricsByCollector",
  "params": {
    "collectorId": "amq",
    "BG": "global-group",
    "Environment": "production",
    "Region": "us-east-1"
    }
  },
  "id": "1"
}
```

#### Response Example

```json
{
  "jsonrpc": "2.0",
  "result": [
    {
      "timestamp": "2025-06-25T00:05:00Z",
      "metricName": "Queues In Flight Messages total",
      "value": 183
    }
  ],
  "id": "1"
}
```
### getPlatformMetricByKey

| Field                  | Details                                                                                          |
|------------------------|---------------------------------------------------------------------------------------------------|
| Method                 | getPlatformMetricByKey                                                                            |
| Type                   | QueryTool                                                                                         |
| Summary                | Fetches a single platform metric value by key.                                                    |
| Inputs (`params`)      | - `metricKey` (string, required)<br> - `timestamp` (optional)                                     |
| Output (`result`)      | A single metric object from get-platform-metrics.raml                                             |
| Performance Guidance   | Optimized for low-latency, atomic metric retrieval.                                               |
| Agent Use Case         | Alerting agent reads one key for rapid decision making.                                           |

#### JSON-RPC Request Example

```json
{
  "jsonrpc": "2.0",
  "method": "getPlatformMetricByKey",
  "params": {
    "collectorId": "arm",
    "BG": "global-group",
    "Environment": "production",
    "metricKey": "cpu.usage"
  },
  "id": "3"
}
```

#### Response Example

```json
{
  "jsonrpc": "2.0",
  "result": {
    "timestamp": "2025-06-25T12:00:00Z",
    "value": 0.81,
  },
  "id": "3"
}
```