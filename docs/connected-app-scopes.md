# Connected App Scopes — CH2 Fork

The upstream Catalyst README lists scopes for the CH1 APIs. The CH2 and Private Spaces endpoints require an expanded scope set. Use the following when creating or updating the Connected App used by this toolkit.

## Scopes to ADD (for CH2 deployments + Private Spaces)

| Scope path                                               | Required by           |
|----------------------------------------------------------|-----------------------|
| Runtime Manager / Read Applications (Runtime Fabric + CloudHub 2.0) | AMC App Manager v2    |
| Runtime Manager / Read Servers                           | AMC App Manager v2    |
| Runtime Manager / Manage Applications (read-only acceptable) | Deployment details |
| Cloudhub 2.0 / Read Private Spaces                       | Private Spaces list   |
| Cloudhub 2.0 / Read Private Space Connections            | VPN/TGW counts        |

Assign these scopes at the **Master Org + every Sub-Org + every environment** the poller traverses. On a trial account, that's usually just the root organisation plus the Sandbox environment.

## Scopes to KEEP (common to both upstream and this fork)

- Exchange / Exchange Viewer
- Design Center / Design Center Developer
- API Manager / View APIs Configuration, View Contracts, View Policies
- Access Management / Profile, View Environment, View Organization

## Scopes to REMOVE (CH1-only, no longer needed once `ch` collector is off)

| Scope path                                | Originally required by |
|-------------------------------------------|------------------------|
| Runtime Manager / Cloudhub Network Viewer | CH1 VPC/VPN/DLB metrics (no CH2 equivalent) |

## Notes for trial accounts

- Trial accounts deploy only to **Shared Space**, not Private Spaces. The `ps` collector still runs but returns an empty summary (zero spaces), which is correct behaviour.
- The `ch2` collector works fine on trial accounts because Shared Space deployments also report `target.provider == "MC"`.
- The Anypoint Platform region is `anypoint.mulesoft.com` for US trials; no property change needed if that's where your trial lives.

## Notes on upstream Issue #220

Upstream Issue #220 (vCores return 0 on CH2 with Connected App) is *caused* by the old `ch` collector calling the CH1 endpoint where a CH2 org has no apps. The `ch2` collector avoids the bug by calling the correct API.
