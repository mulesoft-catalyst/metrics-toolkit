%dw 2.0
output application/json
---
{
	message: "Events loaded successfully",
	errors:  vars.event map {
    		businessGroup: $.businessGroup,
    		errors: $.errors
	}
}