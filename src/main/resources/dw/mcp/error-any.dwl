%dw 2.0
output application/json
---
{
    isError: true,
    content: [
      {
        "type": "text",
        "text": "Error: " ++ error.description
      }
    ]
 }