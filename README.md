Table of Contents
=================

   * [Table of Contents](#table-of-contents)
   * [Metrics Accelerator](#metrics-accelerator)
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
         * [Tableau steps](#tableau-steps)            
         * [MongoDB steps](#mongodb-steps)
            * [Properties specific for MongoDB](#properties-specific-for-mongodb)
      * [Considerations](#considerations)
      * [Some Theory around the Accelerator](#some-theory-around-the-accelerator)
         * [Business Needs](#business-needs)
         * [Data Sources](#data-sources)
         * [Measurements](#measurements)
         * [Problem Space](#problem-space)
         * [Approach - Conceptual](#approach---conceptual)
         * [Approach](#approach)
            * [Conceptual](#conceptual)
            * [Detailed](#detailed)
      * [Final Notes](#final-notes)

# Metrics Accelerator
The **metrics accelerator** (**formerly metrics framework**) is a Mule application intended to collect, aggregate and load platform metrics into different visualization systems; providing out of the box integrations and visualization options, including useful dashboards and charts. In addition to the platform metrics, the accelerator also extends the capabilities to integrate with external applications like Jira, Confluence, Jenkins, Bitbucket and Splunk to gather SDLC metrics. This is an [UNLICENSED software, please review the considerations](UNLICENSE.md). If you need assistance on extending this application, contact your MuleSoft Customer Success representative or MuleSoft Professional Services

## Features
- Compact Mule application (1 single application)
- Provides more than 100 metrics from 3 complementary domains:
	- **Platform Operational Metrics**: collected and calculated automatically based on multiple products from Anypoint Platform: Exchange, Design Center, Runtime Manager, Access Management; covering metrics from applications deployed on-prem (Standalone), RTF and CloudHub.
	- **Platform Benefits**: require manual input to calculate final metrics, crossing information from the "Platform Operational" domain
	- **External SDLC Metrics**: collected and calculated automatically based on multiple external applications: Jira, Confluence, Jenkins, Bitbucket and Splunk;

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
- **Embedded dashboard**: Including an out of the box basic embedded dashboard accessed by running the application offering an UI with a number of metrics obtained
- **Tableau**: including an out of the box dashboard with current consolidated platform metrics
- **MongoDB**

**NOTES:** 
- some adjustments in Metrics Accelerator implementation may be required if the loader does not work as expected for your specific scenario.
- By default, CSV loader output uses comma as the separator char. In order to change the CSV output format, modify the output options in `loader-csv-build-structure.dwl` and/or `loader-csv-build-benefits-structure.dwl` located under `src/main/resources/dw/loader` directory. For more information about CSV output formatting options, check [MuleSoft's official documentation](https://docs.mulesoft.com/mule-runtime/latest/dataweave-formats-csv).

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
OSv2 | ObjectStore V2 Request Count | BG, Environment |

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
- Mule Runtime 4.2.2 or above
- All deployments models are supported: CloudHub, OnPrem hosted Runtimes, Runtime Fabric
- Anypoint Platform credentials, that can be:
  - Anypoint Platform user with the Organization Administrator role in the master organization and all Sub Orgs you want to collect data
  - A Connected App (client credentials) with the following scopes (make sure to include all Sub Orgs and all environments you want to collect data):
    - Design Center
      - Design Center Developer
    - Exchange
      - Exchange Viewer
    - Runtime Manager
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
    - General
      - Profile
      - View Environment
      - View Organization
- (Optional for SDLC metrics) Authorized user with API access to any of the applications: Jira, Confluence, Jenkins, Bitbucket and Splunk for which you want to gather data.

### Steps

1. Clone or download the project from GitHub `git clone git@github.com:mulesoft-catalyst/metrics-accelerator.git`

2. Adjust the properties, run the project and test it - go to your browser and open `http://localhost:8081/console/`

3. Use the postman collection provided (/postman) to understand the API. The postman collection contains the following requests:
  - Platform Metrics:
  	- GET Platform Metrics: retrieves plaform metrics
  	- POST Platform Metrics - Load - Splunk Strategy: used to load platform metrics to Splunk. For more information, see [Splunk steps](#splunk-steps)
  	- POST Platform Metrics - Load - Tableau Strategy: used to load platform metrics to Tableau. For more information, see [Tableau steps](#tableau-steps)
  	- POST Platform Metrics - Load - CSV Strategy: returns platform metrics in CSV format.
  	- POST Platform Metrics - Load - JSON Strategy: returns business metrics in JSON format.
  
  - Business Metrics:
  	- GET Benefits: retrieves business metrics showing the benefits of using the platform
  	- POST Benefits - Load - Splunk Strategy: used to load business metrics to Splunk. For more information, see [Splunk steps](#splunk-steps)
  	- POST Benefits - Load - JSON Strategy: returns business metrics in JSON format.
  
4. If you want to run the application using the poller mode, you have to configure some properties

### Properties configurations

- Default configurations defined in `/src/main/resources/properties/app-{env}.yaml`:
- Make sure to encrypt all sensitive data using the Secure Properties Module: https://docs.mulesoft.com/mule-runtime/4.2/secure-configuration-properties.
- Default secure config file defined in `/src/main/resources/properties/secure/app-{env}.yaml`
- Example `mule.key` used and configured as a Global Property under `global.xml` file


Name | Description | Default Value
------------ | ------------ | ------------
http.port | The port for exposing the metrics-accelerator API | 8081
poller.enabled | Property to enable or disable the poller to collect and load metrics in external systems | false
poller.frequency.cron | Defines the exact frequency (using cron-expressions) to trigger the execution: Recommended to collect metrics once a day | 0 0 0 \* \* ? \*
poller.frequency.timezone | Defines the time zone in which the cron-expression will be efective | GMT-3
aggregation.raw | Flag to define the format of the final response **False**: Won’t provide the raw data but final metrics **True**: Will provide raw data to be aggregated outside this asset | false
collectors | Comma separated set of collectors that should be executed. Default value: all. Possible values available for all deployment models: core (Core Services) ap (Automated Policies) apc (API Clients) apm (API Manager) arm (Standalone Runtimes) dc (Design Center) ex (Exchange). The following collectors are not available for PCE: amq (Anypoint MQ) apma (API Manager Analytics) ch (Cloudhub) rtf (Runtime Fabric) | osv2 (Object Store V2) | all
loader.strategy | In the case of using the poller, this property defines the strategy for loading data in external systems, the options are: **csv, json, logger, splunk, am, elk, tableau, mongodb** | logger
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

**NOTE:** Please note that each external system collector should be self-contained, it means that all associated configuration must be part of the Mule configuration file itself and must not be externalized inside the `global.xml`


### Splunk steps

1. Create 2 indexes: metrics and platform_benefits (of type Events)
2. In the Splunk instance configure an HTTP Event Collector (HEC) associated to these 2 indexes, format _json
3. The token obtained will be used as part of the properties of the Mule application
4. Create a new application  
5. Load the dashboards, simply copy the xmls provided under `/dashboards/splunk` to `{SPLUNK_HOME}/etc/apps/{APP_NAME}/local/data/ui/views`
6. Restart the Splunk instance
7. If you can't copy the dashboard xmls, you can use the UI to create them and using the "Source" option, you can copy & paste the content of the xmls provided

Follow official Splunk documentation: https://docs.splunk.com/Documentation/Splunk/

#### Properties specific for Splunk
Name | Description | Default Value
------------ | ------------ | ------------
splunk.host | HTTP Event Collector (HEC) host |
splunk.port | HEC port | 8088
splunk.protocol | HEC endpoint protocol: HTTPS or HTTP | HTTP
splunk.token | HEC token  |
splunk.source | HEC source | metrics-source
splunk.source.type | Source Type | _json (*)
splunk.index.metrics | Index for storing Platform operational metrics | metrics
splunk.index.benefits | Index for storing Platform benefits | platform_benefits


> (*): Please note that by default, "Source Types" are created with a limit of 3000 characters. The Metrics Accelerator JSON event exceeds this limit. In order to solve that, you must increase this limit adding a new property "TRUNCATE" in the Advanced configuration of the specific Source Type. For example: TRUNCATE = 40000. Depending of the size of your organization, in terms of Business Groups, environments and number of applications and APIs in each environment, this value can be higher.

### ELK steps

**NOTE:** Dashboards were created and tested with Kibana 7.6.2, adjustments may be necessary for other versions

1. The accelerator will load data into the `metrics` and `platformbenefits` indexes. Once data is loaded create an index pattern on Kibana for these indexes
2. Set the loader strategy to `elk` on the `app-{env}.yaml` file, along with the `elk.user` and `elk.password` parameters in the secure `app-{env}.yaml` file
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

### Tableau steps
 
Tableau Dashboards use a JSON File Data Source, which is configured to load data from all JSON files present in a given directory, each JSON file representing a Platform Metrics snapshot.

Metrics Accelerator provides the following approaches to generated those files:
- Using Tableau Strategy (poller or API): this option can only be used if Tableau Desktop can can access the filesystem where Metrics Accelerator is running (**cannot be used for CloudHub or Runtime Fabric, since Tableau Desktop won't be able to access Mule Runtime local filesystem**).
- Using the Get Platform Metrics API operation (check _GET Platform Metrics_ request provided in the Postman collection): suitable if Metrics Accelerator is running on CloudHub or Runtime Fabric, or if you don't have access to Mule Runtime local filesystem.

To learn more about Tableau, follow the official documentation: https://www.tableau.com/support/help

**NOTES:**
- Tableau Dashboard Data Source will only use JSON files which has the following naming pattern: **platform_metrics_agg_\*.json**
- Tableau Dashboard Data Source will only be able to use JSON files containing aggregated data. Thus, Tableau won't be able to render dashboards if JSON files contain raw data (check [Properties Configuration Section](properties_configurations) for futher details.

#### Generating JSON Files Using Poller or API Loader Tableau Strategy

When using the Tableau Strategy, Metrics Accelerator will create the JSON files in the directory defined by  `tableau.outputDir` property (poller) or by `loaderDetails.outputDir` provided in the request (API).

Check _POST Platform Metrics - Load - Tableau Strategy_ Postman collection request if using the API Loader.

***IMPORTANT:*** Make sure `aggregation.raw` property (poller) or `loaderDetails.rawData` (API) is set to ***false***

#### Generating JSON Files Using Get Platform Metrics API operation

1. Use JSON loader strategy via API (check  POST Platform Metrics - Load - JSON Strategy in the provided Postman collection)
2. Save the response content as a JSON file in the directory of your choice. All files must be in the same directory and must respect the naming convention (**platform_metrics_agg_yyyyMMddHHmmssSSS.json**)

***IMPORTANT:*** Make sure the query parameter `raw` is set to ***false***

#### Visualizing Dashboards in Tableau Desktop

1. Before opening a workbook in Tableau Desktop, make sure that you have at least one JSON file available.
2. Make a copy of the desired workbook provided under `/dashboards/tableau`.
3. After copying the workbook, open it in Tableau Desktop. 
4. When prompted, edit workbook connection. Select one of the available JSON files and click Ok.

#### Properties specific for Tableau
Name | Description | Default Value
------------ | ------------ | ------------
tableau.outputDir | Directory where JSON files will be written to. |

#### File name pattern by workbook
Workbook | File Name Pattern 
------------ | ------------ 
current_consolidated | platform_metrics_agg_*.json |

### Embedded Dashboard steps
1. Enable the dashboard by changing the embedded.dashboard.enabled property to "true"
2. Deploy & Run the application
3. Use a web browser to access the applications base URL (e.g. if deployed locally, use http://localhost:8081)
4. Use the "Login" page to enter your Anypoint platform username, password and organization ID
5. Wait for the dashboard to run the metrics request and once done, navigate through the different metrics taken using the UI

### MONGODB steps

**NOTE:** Data was pushed and tested with Mongodb 4.4.1. Adjustments may be necessary for other versions.

1. In MongoDB you will need to create a Database called `matrixdb` and a Collection called `metrics`.
2. Set the loader strategy to `mongodb` on the `app-{env}.yaml` file, along with the `mongodb.username` and `mongodb.password` parameters in the secure `app-{env}.yaml` file
3. Uncomment 2 sections from the pom.xml (dependencies and shared library)
4. Rename the file src/main/mule/loaders/loader-mongodb.disabled to src/main/mule/loaders/loader-mongodb.xml

#### Properties specific for MONGODB
Name | Description | Default Value
------------ | ------------ | ------------
mongodb.host | MongoDB host |
mongodb.port | MongoDB port |
mongodb.database | Database name |
mongodb.colleciton | Collection Name |
mongodb.username | MongoDB user |
mongodb.password | MongoDB password |

## Considerations

- This application can be deployed in any Mule Runtime (OnPrem, CloudHub, RTF)
- The metrics collection will depend on the features available in each account; e.g if the account has the API Manager add-on, the accelerator will collect and aggregate the metrics related to API Manager, otherwise the values will appear as zeroes; if using PCE, there won't be information about API Analytics
- In order to enable or disable specific collectors, you have to change the property "collectors" if using the poller or add a query parameter "collectors" if using the API, including a CSV string as explained in the properties section

## Limitations

- **Access Management** metrics:
	- Not supported on **GovCloud**
- **Exchange** reuse metrics:
	- Not supported for Private Cloud Edition (**PCE**)
- **API Manager** metrics:
	- API Manager metrics available only for accounts with the **API Manager** and Analytics **add-on**
- Runtime Manager (**CloudHub**) application metrics: 
	- CloudHub is not supported on Private Cloud Edition (**PCE**)
- Runtime Manager (**CloudHub**) **networking** metrics - VPCs, VPNs, DLBs and static IPs usage: 
	- Not supported when authenticating with **Connected Apps**
	- Not supported on **GovCloud**
- Runtime Manager (**RuntimeFabric**) metrics: 
    - Runtime Fabric is not supported on **GovCloud**
	- Runtime Fabric is not supported on Private Cloud Edition (**PCE**)
- Runtime Manager (**Standalone**) metrics: 
    - Runtime Manager (Standalone Runtimes) not supported on **GovCloud**
- **API Platform Client Applications** metrics: 
	- Not supported when authenticating with **Connected Apps**
	- Not supported on **GovCloud**
- **Analytics** metrics: 
	- Not supported on **GovCloud**
	- Not supported on Private Cloud Edition (**PCE**)
	- Not supported when authenticating with **Connected Apps**
- **Anypoint MQ** metrics: 
	- Not supported on Private Cloud Edition (**PCE**)
	- Not supported when authenticating with **Connected Apps**
	- Not supported on **GovCloud**
- **OSv2** metrics: 
  - Not supported on Private Cloud Edition (**PCE**)
  - Not supported when authenticating with **Connected Apps**

## Some Theory around the Accelerator
The accelerator is intended to cover the main areas to define and implement metrics using Mule.

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
