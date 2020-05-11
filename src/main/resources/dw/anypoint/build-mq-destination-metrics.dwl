%dw 2.0
output application/json
---
{
    messagesInFlight: sum(payload.inflightMessages.value default [0]),
    messagesSent: sum(payload.messagesSent.value default [0]),
	messagesReceived: sum(payload.messagesReceived.value default [0]),
	messagesAck: sum(payload.messagesAcked.value default [0]),
	messagesPublished: sum(payload.messagesPublished.value default [0]),
	messagesDelivered: sum(payload.messagesDelivered.value default [0])
}