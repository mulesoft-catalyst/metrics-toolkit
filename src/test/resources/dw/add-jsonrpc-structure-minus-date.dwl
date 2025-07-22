%dw 2.0
output application/json
var payloadSanitized = payload map (item) ->
  item - "date"
---
{
  "jsonrpc": "2.0",
  "id": "158ed7b1-895a-410e-b5aa-92ade31c4e9f",
  "result": {
    "content": [
      {
        "type": "text",
        "audience": [],
        "text": write(payloadSanitized, "application/json")
      }
    ],
    "isError": false
  }
}