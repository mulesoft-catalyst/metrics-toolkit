%dw 2.0
output application/json
---
[
		{ 
	        metricName: "applicationsCH",
	        dimensions: [
	        		{
	        			name:"businessGroup",
	        			value: "Master BG"
	        		},
	        		{
	        			name:"environmentType",
	        			value: "Sandbox"
	        		},
	        		{
	        			name:"environmentName",
	        			value: "Dev"
	        		}
	        ],
	        facts: [
	        		{
	        			name:"applications",
	        			value: "5"
	        		}
	        ]
    		},
    		{ 
	        metricName: "applicationsCH",
	        dimensions: [
	        		{
	        			name:"businessGroup",
	        			value: "Master BG"
	        		},
	        		{
	        			name:"environmentType",
	        			value: "Sandbox"
	        		},
	        		{
	        			name:"environmentName",
	        			value: "UAT"
	        		}
	        ],
	        facts: [
	        		{
	        			name:"applications",
	        			value: "2"
	        		}
	        ]
    		},
    		{ 
	        metricName: "applicationsCH",
	        dimensions: [
	        		{
	        			name:"businessGroup",
	        			value: "Master BG"
	        		},
	        		{
	        			name:"environmentType",
	        			value: "Production"
	        		},
	        		{
	        			name:"environmentName",
	        			value: "Production"
	        		}
	        ],
	        facts: [
	        		{
	        			name:"applications",
	        			value: "6"
	        		}
	        ]
    		}

	]