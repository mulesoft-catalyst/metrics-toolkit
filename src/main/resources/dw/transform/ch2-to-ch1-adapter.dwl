%dw 2.0
// ============================================================================
// CloudHub 2.0 -> CloudHub 1.0 shape adapter
// ----------------------------------------------------------------------------
// The upstream Catalyst aggregator (build-platform-metrics-aggregation.dwl)
// computes vCore, app count, and runtime-version metrics by reading:
//
//    $.status                     // expected: "STARTED"
//    $.workers."type".weight      // expected: numeric vCore per worker
//    $.workers.amount             // expected: worker count
//    $.muleVersion.version        // expected: "4.x.y"
//
// CH2 Application Manager v2 returns a totally different shape. This adapter
// maps CH2 fields to the CH1 shape so the aggregator runs unchanged. We also
// attach a ch2 block so CH2-native dashboards can use replica / Private Space
// data when we are ready to extend them.
//
// CH2 reference fields:
//   payload.items[*].application.status       ("RUNNING" | "NOT_RUNNING" | ...)
//   payload.items[*].application.vCores       (numeric, e.g. 0.1, 0.5, 1.0)
//   payload.items[*].target.provider          ("MC" = CloudHub 2.0 Managed,
//                                               includes shared + private space)
//   payload.items[*].target.targetId          (shared space key or private space id)
//   payload.items[*].target.replicas
//   payload.items[*].target.deploymentSettings.runtimeVersion    ("4.9.3:18e-java17")
//   payload.items[*].target.deploymentSettings.resources.cpu.reserved ("100m")
// ============================================================================
output application/java

// Constants kept consistent with the rest of the toolkit.
var APP_STATUS_STARTED_CH1 = "STARTED"
var APP_STATUS_STOPPED_CH1 = "STOPPED"

// Strip ":<buildtag>" suffix so "4.9.3:18e-java17" -> "4.9.3"
fun normaliseRuntime(v: String | Null): String =
	if (v == null) ""
	else (v splitBy ":")[0] default ""

// CH2 "application.status" -> CH1 "status"
fun mapStatus(ch2Status: String | Null): String =
	if (ch2Status == "RUNNING") APP_STATUS_STARTED_CH1 else APP_STATUS_STOPPED_CH1

// Resolve vCore-per-replica. Prefer application.vCores (the simplest and
// most reliable field). If not present, fall back to the millicpu value in
// resources.cpu.reserved (e.g. "100m" -> 0.1, "500m" -> 0.5, "1" -> 1.0).
fun resolveVcoresPerReplica(item: Object): Number =
	if (item.application.vCores != null)
		(item.application.vCores as Number default 0)
	else if (item.target.deploymentSettings.resources.cpu.reserved != null)
	do {
		var raw = item.target.deploymentSettings.resources.cpu.reserved as String
		---
		if (raw endsWith "m")
			((raw replace "m" with "") as Number default 0) / 1000
		else (raw as Number default 0)
	}
	else 0

---
// Filter only CH2-managed deployments. "MC" covers CH2 shared and private
// space. RTF deployments ("RF") are collected by the separate RTF collector.
((payload.items default []) filter ($.target.provider == "MC")) map ((item, idx) -> {
	// ---- CH1-compatible fields (the aggregator reads these) ----
	status: mapStatus(item.application.status),
	workers: {
		"type": {
			name: "CH2-" ++ ((item.target.deploymentSettings.instanceType default "standard") as String),
			weight: resolveVcoresPerReplica(item),
			cpu: (resolveVcoresPerReplica(item) as String) ++ " vCores",
			memory: (item.target.deploymentSettings.resources.memory.reserved default "n/a") as String
		},
		amount: (item.target.replicas default 0) as Number
	},
	muleVersion: {
		version: normaliseRuntime(item.target.deploymentSettings.runtimeVersion)
	},
	// ---- CH2-native fields (for future dashboards; ignored by aggregator) ----
	ch2: {
		deploymentId: item.id,
		name: item.name,
		targetId: item.target.targetId,
		provider: item.target.provider,
		replicas: (item.target.replicas default 0) as Number,
		vCoresPerReplica: resolveVcoresPerReplica(item),
		vCoresTotal: resolveVcoresPerReplica(item) * ((item.target.replicas default 0) as Number),
		applicationStatus: item.application.status default "UNKNOWN",
		deploymentStatus: item.status default "UNKNOWN",
		runtimeVersion: item.target.deploymentSettings.runtimeVersion default "",
		updateStrategy: item.target.deploymentSettings.updateStrategy default "rolling",
		lastModifiedDate: item.lastModifiedDate default null
	}
})
