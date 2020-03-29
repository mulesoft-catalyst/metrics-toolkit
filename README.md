# Metrics Framework
The metrics framework is a Mule application intended to collect, aggregate and load platform metrics into different visualization systems; providing out of the box integrations and visualization options, including useful dashboards and charts.

## Features
- Compact Mule application (1 single application)
- Provides more than 100 metrics from 2 complementary domains:
	- **Platform Operational Metrics**: collected and calculated automatically based on multiple products from Anypoint Platform: Exchange, Design Center, Runtime Manager, Access Management; covering metrics from applications deployed on-prem (Standalone), RTF and CloudHub.
	- **Platform Benefits**: require manual input to calculate final metrics, crossing information from the "Platform Operational" domain

![Domains](/img/domains.png)

### Modes
- Poller (Push mode)
	- Collects, transforms and loads metrics in a defined visualization system
	- Configurable - frequency and status (enabled/disabled).

- API to manage the asset:
	- API endpoint to obtain metrics on-demand (Pull mode)
	- API endpoint for triggering a specific loader to push data to a visualization system
	- API endpoint for loading platform benefits - manual input required
	
### Loader options
- **CSV**
- **JSON**
- **Plain Log**: in case you forward logs to external systems (e.g using Splunk forwarder)
- **Splunk**: Including an out of the box dashboard with more than 80 charts
- **Anypoint Monitoring**: Requires Titanium subscription, dashboard is not provided 
- Tableau: (Not available yet) 
- ELK: (Not available yet)

## Available Metrics

### Platform Metrics

Name | Product | Dimensions | 
------------ | ------------ | ------------ | ------------
Users Total | Access Management | BG |
Active Users | Access Management | BG |
Inactive Users | Access Management | BG |
Active Users Last 60 days | Access Management | BG |
Active Users Last 30 days | Access Management | BG |
Environments Total | Access Management | BG |
Environments Production Total | Access Management | BG |
Environments Sandbox Total | Design Center | BG |
Design Center Assets Total | Design Center | BG |
Design Center API Specs Total | Design Center | BG |
Design Center Fragments Total | Design Center | BG |
Design Center Flow Designer Apps Total | Design Center | BG |
Exchange Assets Total | Exchange | BG |
Exchange API Specs Total | Exchange | BG |
Exchange Connectors Total | Exchange | BG |
Exchange Fragments Total | Exchange | BG |
Exchange HTTP Proxies Total | Exchange | BG |
Exchange Extensions Total | Exchange | BG |
Exchange Custom Assets Total | Exchange | BG |
Exchange Overall Satisfaction | Exchange | BG |
API Manager Client Applications Total | API Platform | BG, Environment |
API Manager API Specs Managed Total | API Manager | BG, Environment |
API Manager API Instances Total | API Manager | BG, Environment |
API Manager API Instances Active Total | API Manager | BG, Environment |
API Manager API Instances Inactive Total | API Manager | BG, Environment |
API Manager API Instances Versions Total | API Manager | BG, Environment |
API Manager API Instances With Policies Total | API Manager | BG, Environment |
API Manager API Instances Without Policies Total | API Manager | BG, Environment |
API Manager API Instances With Security Policies Total | API Manager | BG, Environment |
API Manager API Instances Without Security Policies Total | API Manager | BG, Environment |
API Manager API Instances With Contracts Total | API Manager | BG, Environment |
API Manager API Instances Without Contracts Total | API Manager | BG, Environment |
API Manager API Instances With More Than One Consumer Total | API Manager | BG, Environment |
API Manager API Instances With One or More Consumers Total | API Manager | BG, Environment |
API Manager API Contracts Total | API Manager | BG, Environment |
API Manager Policies Used | API Manager | BG, Environment |
API Manager Policies Used Total | API Manager | BG, Environment |
API Manager Automated Policies Used | API Manager | BG, Environment |
API Manager Automated Policies Used Total | API Manager | BG, Environment |
API Analytics Transactions Last 30 days Total | API Analytics | BG, Environment |
CloudHub VPCs Total | RuntimeManager | BG |
CloudHub VPCs Available Total | RuntimeManager | BG |
CloudHub VPCs Used Total | RuntimeManager | BG |
CloudHub VPNs Total | RuntimeManager | BG |
CloudHub VPNs Available Total | RuntimeManager | BG |
CloudHub VPNs Used Total | RuntimeManager | BG |
CloudHub vCores Total | RuntimeManager | BG, Environment |
CloudHub vCores Available Total | RuntimeManager | BG, Environment |
CloudHub vCores Used Total | RuntimeManager | BG, Environment |
CloudHub Applications Total | RuntimeManager | BG, Environment |
CloudHub Applications Started Total | RuntimeManager | BG, Environment |
CloudHub Applications Stopped Total | RuntimeManager | BG, Environment |
CloudHub Runtime Versions Used | RuntimeManager | BG, Environment |
CloudHub Runtime Versions Used Total | RuntimeManager | BG, Environment |
RTF Fabrics Total | RuntimeManager | BG |
RTF Workers Total | RuntimeManager | BG |
RTF Controllers Total | RuntimeManager | BG |
RTF Cores Total | RuntimeManager | BG |
RTF Memory Total | RuntimeManager | BG |
RTF Cores Per Fabric Average | RuntimeManager | BG |
RTF Memory Per Fabric Average | RuntimeManager | BG |
RTF Cores Used Total | RuntimeManager | BG, Environment |
RTF Cores Reserved Total | RuntimeManager | BG, Environment |
RTF Memory Used Total | RuntimeManager | BG, Environment |
RTF Applications Total | RuntimeManager | BG, Environment |
RTF Applications Started Total | RuntimeManager | BG, Environment |
RTF Applications Stopped Total | RuntimeManager | BG, Environment |
RTF Runtime Versions Used | RuntimeManager | BG, Environment |
RTF Runtime Versions Used Total | RuntimeManager | BG, Environment |
Standalone Mule Servers Total | RuntimeManager | BG, Environment |
Standalone Mule Clusters Total | RuntimeManager | BG, Environment |
Standalone Mule Server Groups Total | RuntimeManager | BG, Environment |
Standalone Mule Applications Total | RuntimeManager | BG, Environment |
Standalone Mule Applications Started Total | RuntimeManager | BG, Environment |
Standalone Mule Applications Stopped Total | RuntimeManager | BG, Environment |
Standalone Mule Runtime Versions | RuntimeManager | BG, Environment |
Standalone Mule Runtime Versions Total | RuntimeManager | BG, Environment |

### Platform Benefits

**These metrics require manual inputs**

Name | Dimensions
------------ | ------------
Developer Productivity | BG
Platform Benefits | BG
Savings From API Reuse | BG
Savings From Maintenance Productivity | BG
Savings From Reuse in Maintenance | BG
Total Savings | BG

## Installation

### Requirements
- Mule Runtime 4.2.1 or above 
- All deployments models are supported: CloudHub, OnPrem hosted Runtimes, Runtime Fabric
- Anypoint Platform user with the Organization Administrator role in the master organization and all Sub Orgs you want to collect data 

### Steps

1. Clone or download the project from GitHub `git clone git@github.com:mulesoft-consulting/metrics-framework-m4.git`

2. Adjust the properties, run the project and test it - go to your browser and open `http://localhost:8081/console/`

3. Use the postman collection provided (/postman) to understand the API

4. If you want to run the application using the poller mode, you have to configure some properties

### Properties configurations 

- Default configurations defined in `/src/main/resources/properties/metrics-framework.{env}.yaml`:
- Make sure to encrypt all sensitive data using the Secure Properties Module: https://docs.mulesoft.com/mule-runtime/4.2/secure-configuration-properties.
- Default secure config file defined in `/src/main/resources/properties/secure/metrics-framework.{env}.yaml`
- Example `mule.key` used and configured as a Global Property under `global.xml` file


Name | Description | Default Value
------------ | ------------ | ------------
http.port | The port for exposing the metrics-framework API | 8081
poller.enabled | Property to enable or disable the poller to collect and load metrics in external systems | false
poller.frequency | In the case of enabling the poller, this property defines the scheduler frequency in minutes: Recommended to collect metrics once a day | 480
aggregation.raw | Flag to define the format of the final response **False**: Won’t provide the raw data but final metrics **True**: Will provide raw data to be aggregated outside this asset | false
loader.strategy | In the case of using the poller, this property defines the strategy for loading data in external systems, the options are: **csv, json, logger, splunk, am, elk, tableau** | logger
anypoint.platform.host | Anypoint Platform Host. Change to eu1.anypoint.mulesoft.com if using the EU Control Plane or to a private host if using PCE | anypoint.mulesoft.com
auth.username | Anypoint Platform username | 
auth.password | Anypoint Platform password | 
auth.orgId | Anypoint Platform master org Id | 

Properties specific for Splunk
Name | Description | Default Value
------------ | ------------ | ------------
splunk.host | HTTP Event Collector (HEC) host | 
splunk.port | HEC port | 8088
splunk.protocol | HEC endpoint protocol: HTTPS or HTTP | HTTP
splunk.token | HEC token  | 
splunk.source | HEC source | metrics-source
splunk.source.type | Source Type | _json
splunk.index.metrics | Index for storing Platform operational metrics | metrics
splunk.index.benefits | Index for storing Platform benefits | platform_benefits

## Considerations

- This application can be deployed in any Mule Runtime (OnPrem, CloudHub, RTF)
- The metrics collection will depend on the features available in each account; e.g if the account uses RTF it will collect information from there, otherwise the values will appear as zeroes; if using PCE, there won't be information about API Analytics 

## Some Theory around the Framework
The framework is intended to cover the main areas to define and implement metrics using Mule.

### Business Needs

There are several business needs around the definition of metrics. The principal goal is to provide **visibility** on 4 main areas: People/Teams, Projects, Processes and Technology. By having visibility on these areas, the involved stakeholders can make decisions, anticipate technical and non-technical needs and optimize time and resources

### Data Sources

Any system containing raw data

### Measurements 

1. **Basic measurements**: 

Examples:
- Number of projects
- Number of incidents

2. **Complex/Composed measurements**

Examples:
- Average daily-TPS per application/project
- vCores usage per application/project - monthly

3. **Indexes/KPIs**

Examples:
- Growth
- Tendencies
- Efficiency / Performance

### Problem Space

How to link business needs, measurements and data sources?

### Approach - Conceptual

1. **Event**: Canonical object representing a metric, based on dimensions and facts

2. **Collectors**: Processes to Collect raw data from different data sources

3. **Aggregators/Transformers**: Transform (calculate, compose, enrich, build metric/event normalized/denormalized objects

4. **Loaders**: Processes to send/load events into external storages/systems 

5. **Visualization**: Third party systems for showing charts and dashboards based on metrics-events (e.g Microstrategy, Tableau, Splunk dashboards, ELK, custom dashboards, BI software, etc)

### Approach

#### Conceptual
![High Level Approach](/img/approach.png)

#### Detailed
![Implementation Approach](/img/implementation_approach.png)

## Final Note
Enjoy and provide feedback / contribute :)
