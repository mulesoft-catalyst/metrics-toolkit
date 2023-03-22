%dw 2.0
output application/json
var usage = payload.workerStatistics map ((workerStatistics, index) -> {
    cpu: workerStatistics.statistics.cpu pluck ((value, key, index) -> {
    ("key"): value}),
    memory: workerStatistics.statistics.memoryPercentageUsed pluck ((value, key, index) -> {
    ("key"): value}),
    id: workerStatistics.id,
    ipAddress: workerStatistics.ipAddress
})
---
usage map ((usage, index) -> {
    id: usage.id,
    avgCpuUsage: avg(usage.cpu map $.key) as String {format: "0.00"} as Number,
    avgMemoryUsage: avg(usage.memory map $.key) as String {format: "0.00"} as Number,
    ipAddress: usage.ipAddress
})