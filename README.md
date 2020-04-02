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

Product | Metric | Dimensions | - 
------------ | ------------ | ------------ | ------------
Access Management | Users Total | BG |
Access Management | Active Users | BG |
Access Management | Inactive Users | BG |
Access Management | Active Users Last 60 days | BG |
Access Management | Active Users Last 30 days |  BG |
Access Management | Environments Total | BG |
Access Management | Environments Production Total | BG |
Access Management | Environments Sandbox Total | BG |
Access Management | API Client Applications Total | BG |
Design Center | Assets Total | BG |
Design Center | API Specs Total | BG |
Design Center | Fragments Total | BG |
Design Center | Flow Designer Apps Total | BG |
Exchange | Assets Total | BG |
Exchange | API Specs Total | BG |
Exchange | Connectors Total | BG |
Exchange | Fragments Total | BG |
Exchange | HTTP Proxies Total | BG |
Exchange | Extensions Total | BG |
Exchange | Custom Assets Total | BG |
Exchange | Overall Satisfaction | BG |
API Manager | API Specs Managed Total | BG, Environment |
API Manager | API Instances Total | BG, Environment |
API Manager | API Instances Active Total | BG, Environment |
API Manager | API Instances Inactive Total | BG, Environment |
API Manager | API Instances Versions Total | BG, Environment |
API Manager | API Instances With Policies Total | BG, Environment |
API Manager | API Instances Without Policies Total | BG, Environment |
API Manager | API Instances With Security Policies Total | BG, Environment |
API Manager | API Instances Without Security Policies Total | BG, Environment |
API Manager | API Instances With Contracts Total | BG, Environment |
API Manager | API Instances Without Contracts Total | BG, Environment |
API Manager | API Instances With More Than One Consumer Total | BG, Environment |
API Manager | API Instances With One or More Consumers Total | BG, Environment |
API Manager | API Contracts Total | BG, Environment |
API Manager | Policies Used | BG, Environment |
API Manager | Policies Used Total | BG, Environment |
API Manager | Automated Policies Used | BG, Environment |
API Manager | Automated Policies Used Total | BG, Environment |
API Analytics | Transactions Last 30 days Total | BG, Environment |
RuntimeManager - CloudHub - Networking | VPCs Total | BG |
RuntimeManager - CloudHub - Networking | VPCs Available Total | BG |
RuntimeManager - CloudHub - Networking | VPCs Used Total | BG |
RuntimeManager - CloudHub - Networking | VPNs Total | BG |
RuntimeManager - CloudHub - Networking | VPNs Available Total | BG |
RuntimeManager - CloudHub - Networking | VPNs Used Total | BG |
RuntimeManager - CloudHub - Networking | DLBs Total | BG |
RuntimeManager - CloudHub - Networking | DLBs Available Total | BG |
RuntimeManager - CloudHub - Networking | DLBs Used Total | BG |
RuntimeManager - CloudHub - Networking | Static IPs Total | BG |
RuntimeManager - CloudHub - Networking | Static IPs Available Total | BG |
RuntimeManager - CloudHub - Networking | Static IPs Used Total | BG |
RuntimeManager - CloudHub - Applications | vCores Total | BG, Environment |
RuntimeManager - CloudHub - Applications | vCores Available Total | BG, Environment |
RuntimeManager - CloudHub - Applications | vCores Used Total | BG, Environment |
RuntimeManager - CloudHub - Applications | Applications Total | BG, Environment |
RuntimeManager - CloudHub - Applications | Applications Started Total | BG, Environment |
RuntimeManager - CloudHub - Applications | Applications Stopped Total | BG, Environment |
RuntimeManager - CloudHub - Applications | Runtime Versions Used | BG, Environment |
RuntimeManager - CloudHub - Applications | Runtime Versions Used Total | BG, Environment |
RuntimeManager - RTF - Capacity | Fabrics Total | BG |
RuntimeManager - RTF - Capacity | Workers Total | BG |
RuntimeManager - RTF - Capacity | Controllers Total | BG |
RuntimeManager - RTF - Capacity | Cores Total | BG |
RuntimeManager - RTF - Capacity | Memory Total | BG |
RuntimeManager - RTF - Capacity | Cores Per Fabric Average | BG |
RuntimeManager - RTF - Capacity | Memory Per Fabric Average | BG |
RuntimeManager - RTF - Applications | Cores Used Total | BG, Environment |
RuntimeManager - RTF - Applications | Cores Reserved Total | BG, Environment |
RuntimeManager - RTF - Applications | Memory Used Total | BG, Environment |
RuntimeManager - RTF - Applications | Applications Total | BG, Environment |
RuntimeManager - RTF - Applications | Applications Started Total | BG, Environment |
RuntimeManager - RTF - Applications | Applications Stopped Total | BG, Environment |
RuntimeManager - RTF - Applications | Runtime Versions Used | BG, Environment |
RuntimeManager - RTF - Applications | Runtime Versions Used Total | BG, Environment |
RuntimeManager - Standalone | Mule Servers Total | BG, Environment |
RuntimeManager - Standalone | Mule Clusters Total | BG, Environment |
RuntimeManager - Standalone | Mule Server Groups Total | BG, Environment |
RuntimeManager - Standalone | Mule Applications Total | BG, Environment |
RuntimeManager - Standalone | Mule Applications Started Total | BG, Environment |
RuntimeManager - Standalone | Mule Applications Stopped Total | BG, Environment |
RuntimeManager - Standalone | Mule Runtime Versions | BG, Environment |
RuntimeManager - Standalone | Mule Runtime Versions Total | BG, Environment |

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
