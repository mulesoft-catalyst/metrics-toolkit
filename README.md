# Metrics Framework
The following framework is intended to cover the main areas to define and implement metrics using Mule.

## Framework
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

### Approach - API-Led Connectivity

![Scenario 1](/img/approach.png)

## Configuration
Default configurations defined in `/src/main/resources/metrics-framework.{env}.yaml`:


## Run in Anypoint Studio
1. Clone the project from GitHub `git clone git@github.com:mulesoft-consulting/metrics-framework-m4.git`

2. Run the project and test it - go to your browser and open `http://localhost:8081/console/`

## Deploy through Runtime Manager
1. Deploy the app from Studio or from the Runtime Manager UI

## Final Note
Enjoy and provide feedback / contribute :)
