%dw 2.0
// ============================================================================
// Private Spaces -> Networking metrics summariser
// ----------------------------------------------------------------------------
// Replaces the CH1 runtimeManagerMetrics.cloudhub.networking section.
// CH2 constructs used:
//   - Private Spaces  (replaces VPCs)
//   - VPN connections (replaces VPNs)
//   - Transit Gateway attachments (replaces peerings)
//   - Private Ingress (replaces DLBs)
// Static IPs do not exist as a separate concept in CH2 and are omitted.
// ============================================================================
output application/json
---
{
	privateSpacesTotal: sizeOf(payload.content default payload default []),

	privateSpacesByRegion: (payload.content default payload default []) groupBy ($.region default "unknown")
		mapObject ((v, k) -> { (k): sizeOf(v) }),

	privateSpacesByEnvType: (payload.content default payload default []) groupBy
		(if (isEmpty($.environmentIds default [])) "unassigned"
		 else ((($.environmentTypes default ["mixed"])[0]) as String default "mixed"))
		mapObject ((v, k) -> { (k): sizeOf(v) }),

	privateSpaces: (payload.content default payload default []) map ((ps, idx) -> {
		id: ps.id,
		name: ps.name,
		region: ps.region default "unknown",
		status: ps.status default "UNKNOWN",
		cidrBlock: ps.network.cidrBlock default "",
		reservedCidrs: ps.network.reservedCidrs default [],
		associatedEnvironmentCount: sizeOf(ps.environmentIds default []),
		connectionCount: sizeOf(ps.connections default []),
		vpnConnections: sizeOf((ps.connections default []) filter ($."type" == "vpn" or $.kind == "vpn")),
		tgwAttachments: sizeOf((ps.connections default []) filter ($."type" == "tgw" or $.kind == "tgw")),
		firewallRules: sizeOf(ps.firewallRules default [])
	}),

	// Aggregate roll-ups
	vpnConnectionsTotal: sum(((payload.content default payload default []) map
		sizeOf(($.connections default []) filter ($."type" == "vpn" or $.kind == "vpn")))
		default [0]),
	tgwAttachmentsTotal: sum(((payload.content default payload default []) map
		sizeOf(($.connections default []) filter ($."type" == "tgw" or $.kind == "tgw")))
		default [0])
}
