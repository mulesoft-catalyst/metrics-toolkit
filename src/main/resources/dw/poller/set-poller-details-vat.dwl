%dw 2.0
output application/java
---
{
	generalPollerEnabled: p('poller.enabled'),
	sdlcPollerEnabled: p('sdlc.poller.enabled')
}