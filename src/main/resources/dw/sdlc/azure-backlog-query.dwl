%dw 2.0
output application/json
---
{
  "query": "Select [System.Id], [System.Title], [System.State], [System.WorkItemType] From WorkItems Where [System.IterationPath] = @project"
}