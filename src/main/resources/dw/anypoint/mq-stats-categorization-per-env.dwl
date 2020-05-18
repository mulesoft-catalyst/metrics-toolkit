%dw 2.0
output application/java
---
{
    "queues": sizeOf((payload filter ($.fifo == false and $."type" == "queue")).queueId default []),
    "exchanges": sizeOf((payload filter ($."type" == "exchange")).exchangeId default []),
    "fifoQueues": sizeOf((payload filter ($.fifo == true and $."type" == "queue")).queueId default [])
}