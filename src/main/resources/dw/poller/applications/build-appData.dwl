%dw 2.0
output application/java
---
{
	date: vars.bulkDate,
	orgId: vars.organizationData.id,
	orgName: vars.organizationData.name,
	envId: vars.envData.id,
	envName: vars.envData.name,
	isProduction: vars.envData.isProduction,
	applicationName: payload.domain,
	status: payload.status,
	properties: payload.properties,
	workerStatistics: {
		amount: payload.workers.amount,
		'type':   payload.workers.'type'.name,
		weight: payload.workers.'type'.weight,
		cpuAllocated: payload.workers.'type'.cpu,
		memoryAllocated: payload.workers.'type'.memory,
		workers: vars.workersData
	},
	firstDeployment: vars.deploymentsData.firstDeployment.endTime,
	lastDeployment: vars.deploymentsData.lastDeployment.endTime,
	totalOfDeployments: vars.deploymentsData.totalOfDeployments,
	ipAddresses: payload.ipAddresses,
	muleVersion: payload.muleVersion.version,
	region: payload.region,
	persistentQueues: payload.persistentQueues,
	loggingCustomLog4JEnabled: payload.loggingCustomLog4JEnabled 	
}