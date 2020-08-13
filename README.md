Table of Contents
=================

   * [Table of Contents](#table-of-contents)
   * [Metrics Framework](#metrics-framework)
      * [Features](#features)
         * [Modes](#modes)
         * [Loader options](#loader-options)
      * [Available Metrics](#available-metrics)
         * [Platform Metrics](#platform-metrics)
         * [Platform Benefits](#platform-benefits)
         * [SDLC Metrics](#sdlc-metrics)
      * [Installation](#installation)
         * [Requirements](#requirements)
         * [Steps](#steps)
         * [Properties configurations](#properties-configurations)
            * [SDLC metrics collectors properties configuration](#sdlc-metrics-collectors-properties-configuration)
         * [Splunk steps](#splunk-steps)
            * [Properties specific for Splunk](#properties-specific-for-splunk)
         * [ELK steps](#elk-steps)
            * [Properties specific for ELK](#properties-specific-for-elk)
      * [Considerations](#considerations)
      * [Some Theory around the Framework](#some-theory-around-the-framework)
         * [Business Needs](#business-needs)
         * [Data Sources](#data-sources)
         * [Measurements](#measurements)
         * [Problem Space](#problem-space)
         * [Approach - Conceptual](#approach---conceptual)
         * [Approach](#approach)
            * [Conceptual](#conceptual)
            * [Detailed](#detailed)
      * [Final Notes](#final-notes)

# Metrics Framework
The metrics framework is a Mule application intended to collect, aggregate and load platform metrics into different visualization systems; providing out of the box integrations and visualization options, including useful dashboards and charts. In addition to the platform metrics, the framework also extends the capabilities to integrate with external applications like Jira, Confluence, Jenkins, Bitbucket and Splunk to gather SDLC metrics. This is an [UNLICENSED software, please review the considerations](UNLICENSE.md). If you need assistance for extending this, contact MuleSoft Professional Services

## Features
- Compact Mule application (1 single application)
- Provides more than 100 metrics from 3 complementary domains:
	- **Platform Operational Metrics**: collected and calculated automatically based on multiple products from Anypoint Platform: Exchange, Design Center, Runtime Manager, Access Management; covering metrics from applications deployed on-prem (Standalone), RTF and CloudHub.
	- **Platform Benefits**: require manual input to calculate final metrics, crossing information from the "Platform Operational" domain
	- **External sdlc Metrics**: collected and calculated automatically based on multiple external applications: Jira, Confluence, Jenkins, Bitbucket and Splunk;

![Domains](/img/domains.png)

### Modes
- Poller (Push mode)
	- Collects, transforms and loads metrics in a defined visualization system
	- Configurable - frequency (cron expression and timezone ) and status (enabled/disabled).

- API to manage the asset:
	- API endpoint to obtain metrics on-demand (Pull mode)
	- API endpoint for triggering a specific loader to push data to a visualization system
	- API endpoint for loading platform benefits - manual input required

### Loader options
- **CSV**
- **JSON**
- **Plain Log**: in case you forward logs to external systems (e.g using Splunk forwarder)
- **Splunk**: Including an out of the box dashboard with more than 100 charts
- **ELK**: Including out of the box, basic, Kibana dashboards
- **Anypoint Monitoring**: Requires Titanium subscription, dashboard is not provided
- Tableau: (Not available yet)

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
Exchange | Mule 3 Connectors Total | BG |
Exchange | SOAP APIs Total | BG |
Exchange | Fragments Total | BG |
Exchange | HTTP Proxies Total | BG |
Exchange | Policies Total | BG |
Exchange | Extensions Total | BG |
Exchange | Custom Assets Total | BG |
Exchange | Overall Satisfaction | BG |
Exchange | API Fragments reuse | BG |
Exchange | API Spec reuse | BG |
Exchange | Extensions reuse | BG |
Exchange | API Specs managed in API Manager reuse | BG, Environment |
Exchange | Policies applied in API Manager reuse | BG, Environment |
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
RuntimeManager - RTF - Capacity | Cores Allocated Total | BG |
RuntimeManager - RTF - Capacity | Memory Allocated Total | BG |
RuntimeManager - RTF - Capacity | Cores Allocated Per Fabric Average | BG |
RuntimeManager - RTF - Capacity | Memory Allocated Per Fabric Average | BG |
RuntimeManager - RTF - Applications | Cores Allocated Total | BG, Environment |
RuntimeManager - RTF - Applications | Memory Allocated Total | BG, Environment |
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
MQ | Queues total | BG, Environment, Region |
MQ | FIFO Queues total | BG, Environment, Region |
MQ | Queues In Flight Messages total | BG, Environment, Region |
MQ | Queues Received Messages total | BG, Environment, Region |
MQ | Queues Sent Messages total | BG, Environment, Region |
MQ | Queues ACK Messages total | BG, Environment, Region |
MQ | Exchanges total | BG, Environment, Region |
MQ | Exchanges Published Messages total | BG, Environment, Region |
MQ | Exchanges Delivered Messages total | BG, Environment, Region |

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

### SDLC Metrics

**These metrics are optional and can be cherry picked as per your requirement**

Name | Metric
------------ | ------------
BitBucket | Total Number of BitBucket Repositories
Confluence | Total Number of Confluence pages
Confluence | Total Number of Confluence pages created in the last 30 days
Confluence | Total Number of Confluence pages updated in the last 30 days
Confluence | Top Contributors in the last 30 days and associated number of pages created
Jenkins | Total Number of Jenkins jobs
Jenkins | Total Number of failed Jenkins jobs
Jenkins | Total Number of successful Jenkins jobs
Jenkins | Total Number of unexecuted Jenkins jobs
Jira | Total Number of Jira stories in the backlog
Jira | Total Number of Jira stories in the current sprint
Jira | Jira stories categorized by type and associated count in the current sprint
Jira | Jira stories categorized by status and associated count in the current sprint
Splunk | Total Number of Splunk dashboards

## Installation

### Requirements
- Mule Runtime 4.2.1 or above
- All deployments models are supported: CloudHub, OnPrem hosted Runtimes, Runtime Fabric
- Anypoint Platform credentials, that can be:
  - Anypoint Platform user with the Organization Administrator role in the master organization and all Sub Orgs you want to collect data
  - A Connected App (client credentials) with the following scopes (make sure to include all Sub Orgs you want to collect data):
    - Exchange
      - Exchange Viewer
    - Runtime Runtime
      - Cloudhub Network Viewer
      - Read Alerts
      - Read Applications
      - Read Servers
    - Runtime Fabric
      - Manage Runtime Fabrics
    - API Manager
      - View APIs Configuration
      - View Contracts
      - View Policies
    - Data Gateway
      - Data Gateway Viewer
    - API Federation
      - Data Graph Viewer
    - ANG Governance
      - Governance Manager - Viewer
      - Governance Reports Viewer
    - Object Store
      - Store Metrics Viewer
      - View stores
    - General
      - Audit Log Viewer
      - Profile
      - View Environment
      - View Organization
- (Optional for SDLC metrics) Authorized user with API access to any of the applications: Jira, Confluence, Jenkins, Bitbucket and Splunk for which you want to gather data.

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
poller.frequency.cron | Defines the exact frequency (using cron-expressions) to trigger the execution: Recommended to collect metrics once a day | 0 0 0 \* \* ? \*
poller.frequency.timezone | Defines the time zone in which the cron-expression will be efective | GMT-3
aggregation.raw | Flag to define the format of the final response **False**: Won’t provide the raw data but final metrics **True**: Will provide raw data to be aggregated outside this asset | false
collectors | Comma separated set of collectors that should be executed. Default value: all. Possible values available for all deployment models: core (Core Services) ap (Automated Policies) apc (API Clients) apm (API Manager) arm (Standalone Runtimes) dc (Design Center) ex (Exchange). The following collectors are not available for PCE: amq (Anypoint MQ) apma (API Manager Analytics) ch (Cloudhub) rtf (Runtime Fabric) | all
loader.strategy | In the case of using the poller, this property defines the strategy for loading data in external systems, the options are: **csv, json, logger, splunk, am, elk, tableau** | logger
anypoint.platform.host | Anypoint Platform Host. Change to eu1.anypoint.mulesoft.com if using the EU Control Plane or to a private host if using PCE | anypoint.mulesoft.com
auth.mode | Authentication mode. Valid options are: platform-credentials or connected-app-credentials | platform-credentials
auth.username | Anypoint Platform username. Used when auth.mode is platform-credentials |
auth.password | Anypoint Platform password. Used when auth.mode is platform-credentials |
auth.clientId | Anypoint Platform Connected App Client Id. Used when auth.mode is connected-app-credentials |
auth.clientSecret | Anypoint Platform Connected App Client Secret. Used when auth.mode is connected-app-credentials |
auth.orgId | Anypoint Platform master org Id |
ignoreLists.organizations | An array (comma-separated values) of Anypoint Platform sub-organizations id that will be ignored while retrieving metrics e.g "cdfa4e7d-47cd-n1h1-8f39-6a73fbb9ffcb, cdfa4e7d-47cd-n2h2-8f39-6a73fbb9ffcb" |

#### SDLC metrics collectors properties configuration
Name | Description | Default Value
------------ | ------------ | ------------
sdlc.confluence.enabled | Property to enable or disable application to collect metrics from Confluence | false
sdlc.confluence.host | Confluence server host |
sdlc.confluence.port | Confluence server port |
sdlc.confluence.path | Context url of the [Confluence REST API](https://developer.atlassian.com/cloud/confluence/rest/)  |
sdlc.confluence.user | Authorized Confluence user to access REST APIs |
sdlc.confluence.token | User token to access REST APIs |
sdlc.bitbucket.enabled | Property to enable or disable application to collect metrics from Bitbucket | false
sdlc.bitbucket.host | Bitbucket server host |
sdlc.bitbucket.port | Bitbucket server port |
sdlc.bitbucket.path | Context url of the [Bitbucket REST API](https://developer.atlassian.com/bitbucket/api/2/reference/resource/)  |
sdlc.bitbucket.user | Authorized Bitbucket user to access REST APIs |
sdlc.bitbucket.token | User token to access REST APIs |
sdlc.jira.enabled | Property to enable or disable application to collect metrics from Jira | false
sdlc.jira.host | Jira server host |
sdlc.jira.port | Jira server port |
sdlc.jira.path | Context url of the [Jira REST API](https://developer.atlassian.com/cloud/jira/platform/rest/v2/)  |
sdlc.jira.backlogPath | Context url of the [Jira REST API](https://developer.atlassian.com/cloud/jira/platform/rest/v2/) to fetch stories from backlog  |
sdlc.jira.user | Authorized Jira user to access REST APIs |
sdlc.jira.token | User token to access REST APIs |
sdlc.jenkins.enabled | Property to enable or disable application to collect metrics from Jenkins | false
sdlc.jenkins.host | Jenkins server host |
sdlc.jenkins.port | Jenkins server port |
sdlc.jenkins.path | Context url of the [Jenkins REST API](https://wiki.jenkins.io/display/JENKINS/Remote+access+API)  |
sdlc.jenkins.user | Authorized Jenkins user to access REST APIs |
sdlc.jenkins.token | User token to access REST APIs |
sdlc.splunk.enabled | Property to enable or disable application to collect metrics from Splunk | false
sdlc.splunk.host | Splunk server host |
sdlc.splunk.port | Splunk server port |
sdlc.splunk.path | Context url of the [Splunk REST API](https://docs.splunk.com/Documentation/Splunk/8.0.3/RESTTUT/RESTandCloud)  |
sdlc.splunk.user | Authorized Splunk user to access REST APIs |
sdlc.splunk.password | Password to access REST APIs |

### Splunk steps

1. Create 2 indexes: metrics and platform_benefits (of type Events)
2. In the Splunk instance configure an HTTP Event Collector (HEC) associated to these 2 indexes, format _json
3. The token obtained will be used as part of the properties of the Mule application
4. Load the dashboards, simply copy the xmls provided under `/dashboards/splunk` to `{SPLUNK_HOME}/etc/apps/{APP_NAME}/local/data/ui/views`
5. If you can't copy the dashboard xmls, you can use the UI to create them and using the "Source" option, you can copy & paste the content of the xmls provided

Follow official Splunk documentation: https://docs.splunk.com/Documentation/Splunk/

#### Properties specific for Splunk
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

### ELK steps

1. The Framework will load data into the `metrics` and `platformbenefits` indexes. Once data is loaded create an index pattern on Kibana for these indexes
2. Set the loader strategy to `elk` on the `metrics-framework-{env}.yaml` file, along with the `elk.user` and `elk.password` parameters in the secure `metrics-framework-{env}.yaml` file
3. To load the dashboards, replace the `<YOUR-INDEX-PATTERN-ID>` occurrences on all of the dashboards provided under `/dashboards/elk` with your index pattern ID. The index pattern ID can be obtained on Kibana under `Management>>Index Patterns`
4. Log into your Kibana instance, and on the `Management>>Saved Objects` menu, click on import for each dashboard. This will import all dashboards and visualizations


Follow official ELK documentation: https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html
https://www.elastic.co/guide/en/kibana/current/index.html

#### Properties specific for ELK
Name | Description | Default Value
------------ | ------------ | ------------
elk.host | Elasticsearch host |
elk.port | Elasticsearch port | 9200
elk.protocol | Elasticsearch protocol: HTTP | HTTP
elk.user | Elasticsearch username  |
elk.password | Elasticsearch password |
elk.index.metrics | Index for storing Platform operational metrics | metrics
elk.index.benefits | Index for storing Platform benefits | platformbenefits

## Considerations

- This application can be deployed in any Mule Runtime (OnPrem, CloudHub, RTF)
- The metrics collection will depend on the features available in each account; e.g if the account has the API Manager add-on, the framework will collect and aggregate the metrics related to API Manager, otherwise the values will appear as zeroes; if using PCE, there won't be information about API Analytics
- In order to enable or disable specific collectors, you have to change the property "collectors" if using the poller or add a query parameter "collectors" if using the API, including a CSV string as explained in the properties section

## Limitations

- API Manager metrics:
	- API Manager API allows to retrieve up to 100 assets (APIs) per request call. As of today, the metrics framework only supports one request call, therefore there is a limitation that will prevent the metrics framework to retrieve stats for an organization that is currently managing +100 APIs

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

## Final Notes
Enjoy and provide feedback / contribute :)
