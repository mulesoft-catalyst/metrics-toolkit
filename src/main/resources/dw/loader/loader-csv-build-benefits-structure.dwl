%dw 2.0
output application/csv
var benefits = "Platform Benefits"
var envNA = "NA"
---
flatten (payload map ((event, eventIndex) -> ([
    
    {
        name: "Developers Productivity", value: event.developerProductivity,
        businessGroup: event.businessGroup, date: event.date, group: benefits, environmentType: envNA
    },
    {
        name: "Savings from API Reuse", value: event.savingFromAPIReuse,
        businessGroup: event.businessGroup, date: event.date, group: benefits, environmentType: envNA
    },
    {
        name: "Savings from Maintenance Productivity", value: event.savingFromMaintenanceProductivity,
        businessGroup: event.businessGroup, date: event.date, group: benefits, environmentType: envNA
    },
    {
        name: "Savings from Reuse in Maintenance", value: event.savingFromReuseInMaintenance,
        businessGroup: event.businessGroup, date: event.date, group: benefits, environmentType: envNA
    },
    {
        name: "Total Savings", value: event.totalSavings,
        businessGroup: event.businessGroup, date: event.date, group: benefits, environmentType: envNA
    }
  ])
))