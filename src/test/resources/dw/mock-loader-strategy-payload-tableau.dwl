%dw 2.0
output application/json
---
{
	loaderDetails: {
		strategy: "tableau",
		rawData: "false",
		tableau: {
			outputDir: "/tmp/test"	
		}
	}
}