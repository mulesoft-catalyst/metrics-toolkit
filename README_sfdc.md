
Introduction
============

This README introduces how to configure the Salesforce Einstein Analytics `loader` into the Metrics Framework to inject data into your Salesforce Dashboards.

For customer who have a predominantly Salesforce-centric landscape, Joint Mulesoft & Salesforce customers sometimes require the metrics to be fed into their existing dashboarding capabilities, such as the market leading **Einstein Analytics** (EA) dashboard capability embedded within the **Salesforce** platform.

The SFDC-EA integration and enhancement to the tool is made more convenient through the use of the **Out Of The Box** Mulesoft connector to **Salesforce Analytics**.

This page highlight:

*   The logic within the **Metrics Accelerator** tool to collect, format and inject the Metrics into **Salesforce Einstein Analytics**
*   The steps required to receive and interpret the Metrics Data within **Salesforce Analytics** and allow the custom creation of dashboards

Metrics Analytics Basics
========================

From the diagram in the main page, it can be seen that data can be '**collected**' from multiple sources, not just the Anypoint Platform Management APIs.

Once the data is collected and aggregated, it is either returned in an aggregated format, or it can be '**loaded**' into an end system for which their is a '**loader**' implementation.

This `sfdc` loader is one such loader to inject into Einstein Analytics.

Einstein Analytics components
-------------------------------

A '**salesforce-analytics loader'** has been developed which utilises (piggy-backs on) the existing **CSV loader** format within the Metrics Accelerator framework (this is useful because Salesforce Einstein Analytics can easily consume CSV formats)

This '**loader**'  simply calls the **CSV loader** sub-flow to acquire all the correct information in the correct format, then utilise the **Salesforce Analytics Connector** to inject the data into the configured Salesforce system.

The **Salesforce Analytics connector** is configured either from payload (body) parameters sent in the RESTful 'loader' request payload, or from the 'Runtime Properties' provided wither through secure properties or Runtime Manager properties if the Metrics application needs to run in a poller mode.

It is expected that, along with the **summarised** data currently collected and injected into SFDC-EA, that this will be further enhanced in future to also provide detailed metrics on each API or business object collected (e.g. number of calls made to each API, APIs developed per user, list of APIs per business group, list of environments per business group, vCores assigned per API)

The current data provides such metrics as:

*   Total count of APIs with Policies per Business Group
*   Total vCores used in Production & Sandbox per business group, 
*   Total count of active & inactive users per Business Group
*   Number of Environments per Business Group
*   Number of Design Center Specs/Fragments/Assets per Business Group
*   Number of Exchange assets, APIs, Fragments, Custom assets per Business Group
*   etc (a total of 145 metrics per business group) - although some (`RTF, Anypoint MQ, Standalone Mule` stats) may not be relevant to all customers



### Poller CRON Settings - Default and Overrides

The Metrics application utilises a **cron** style polling configuration which has a default setting specified in the **app-dev.yaml** file.

The default is therefore to poll at midnight every day, and this will result in daily updates for the Metrics data

NOTE: Realistically this should be frequent enough, however, for testing, this may need be modified to have more frequent updates

#### Overriding the default polling settings

The default polling is once per day, but in order to override this, the following can be specified in the **Properties** when deploying the application to Cloudhub

`poller.frequency.cron`

The following table gives some examples of use - but reference (and testing of expressions) should refer to [https://www.freeformatter.com/cron-expression-generator-quartz.html](https://www.freeformatter.com/cron-expression-generator-quartz.html)


| Cron config string 'poller.frequency.cron' | Description of polling frequency |
| ------------------------------------------ | :-------------------------------:|
| "0 0 \* ? \* \* \*" | At second :00 of minute :00 of every hour |
| "**0 \*/30 \* ? \* \*"** | Every 30 minutes |
| "**0 0 \*/4 ? \* \*"** | Every 4 hours |
| **"0 0 12 ? \* MON-FRI"** | Every Weekday at noon |


Deploying the application
-------------------------

This is the same as any other Mulesoft Application being deployed to the Cloudhub environment.  You will need to deploy within Runtimes Manager and configure the following Runtime Properties:
*   The following Runtime Manager Properties:

  Properties

  ```
  anypoint.platform.config.analytics.agent.enabled=false  
  anypoint.platform.host=[eu1.anypoint.mulesoft.com](http://eu1.anypoint.mulesoft.com)

  poller.enabled=true  
  poller.frequency.timezone=GMT

  poller.frequency.cron="0 30 12 ? \* \* \*"

  embedded.dashboard.enabled=true  
  loader.strategy=sfdc  
  aggregation.raw=false  
  collectors=all

  auth.mode=platform-credentials  
  secure\\:\\:auth.orgId=**<Root Org ID>**  
  secure\\:\\:auth.username=**<Anypoint Platform Unencrypted Username>**  
  secure\\:\\:auth.password=**<Anypoint Platform User Unencrypted Password>**

  sfdc.appName=IPAAS_Anypoint_Metrics_App  
  sfdc.notificationEmail=**<iPaaS Operations Email Address>**  
  sfdc.sendNotification=ALWAYS  
  sfdc.dataSetName=IPAAS_Anypoint_Metrics_DataSet

  secure\\:\\:sfdc.username=**<SFDC-EA Account Unencrypted Username>**  
  secure\\:\\:sfdc.password=**<SFDC-EA Account Unencrypted Password>**

  secure\\:\\:sfdc.securityToken=**<SFDC-EA Account Unencrypted Security Token>**  
  sfdc.authUrl=**<Your Auth URL for this environment e.g. https://test.salesforce.com/services/Soap/u/48.0>**
  ```

  NOTE: When deploying to SFDC Prod and PreProd environments, the following properties are likely different to Production SFDC:

  *   sfdc.authUrl
  *   sfdc.username
  *   sfdc.password
  *   sfdc.securityToken



NOTE: The Anypoint User must have **OrgAdmin rights** on all Business Groups down from the Root Org.
NOTE: This may need to be extended to **Cloudhub Admin** rights for analytics data.

Invoking the application manually
---------------------------------

Once deployed, the documented endpoints will be available and can be invoked with a RESTful Client such as Postman

e.g. **GET/POST** https://<dlb\_name>/<application\_name>/<**resource**\>

Where resource can be:

*   **GET - /api/platform-metrics?** - with additional Query Parameters as per the documentation in the GitLab page (**Secondary Focus - but good for testing data content)**
*   GET - / - as the root embedded Web Dashboard (which is for ease of use although unable to modify the dashboard content)
*   GET - /api/business-metrics - to retrieve some reus savings metrics based on reuse calculations and costs provided as parameters
*   GET - /api/sdlc-metrics - returns metrics based on JIRA/Jenkins/Confluence collectors - see documentation link in GitHub
*   **POST - /api/platform-metrics/load** - with a payload to indicate the loader to use, and where to post the data. **(Primary focus for this process is to 'Load' into 'SFDC-EA')**

### Immediate Metrics Response:

Calling the documented 'GET' request on the Analytics Application - without loading data into an external system - will return JSON formatted results data:

This will provide a JSON formatted response , which may be of use to other applications or dashboards.

However, for the purposes of pushing data into the **SF Analytics Platform**, you need to call a specific **loader** which injects data into the SFDC-EA APIs.

### Request to 'load' metrics to SFDC


**IMPORTANT : Prerequisite:**

Before you can successfully inject data into SFDC, you must first create the application in **SFDC-Einstein Analytics** - See Below SFDC Setup instructions.

The Metrics data can either be injected upon manual request (manually invoking the request to `load` data to SFDC), or automatically through the polling mechanism by configuring the Schedule

In order to inject data directly from the Metrics Application to the SFDC Instance - you can utilise the following payload (from say Postman):

***Headers***

```
'X-ANYPNT-ORG-ID: '
'X-ANYPNT-USERNAME: '
'X-ANYPNT-PASSWORD: '
'Content-Type: application/json'
```

***Payload***

```{
  "loaderDetails": {
     "strategy": "sfdc",
     "rawData": "false",
     "sfdc" : {
       "username": "<YOUR SFDC USERNAME>",
       "password": "<YOUR SFDC PASSWORD>",
       "securityToken": "<YOUR SFDC API SECURITY TOKEN - See Below>",
       "dataSetName" : "<YOUR EA APPLICATION NAME - See Below>",
       "appName": ""
      }
    }
  }
```

### Securing the Anypoint Account Credentials

*   REF: [https://docs.mulesoft.com/mule-runtime/4.3/secure-configuration-properties](https://docs.mulesoft.com/mule-runtime/4.3/secure-configuration-properties)

Encrypting Values (Common for all of the below)

Any sensitive values need to be **encrypted** using the same Encryption Key as the one embedded in the **Secure Property Placeholder** which is defined in the project within the following file:

`main/mule/global.xml`

The default '**key**' used to encrypt is specified in the '**mule.key**' property which defaults to a value of ' **_thisshouldbeakey_** ' and should be overridden when the application is deployed using the Runtime Manager Properties.

However, the above default will be used for the following instructions to show how the properties should be encrypted/protected.

*   Download the Secure Properties command line tool from here: [https://docs.mulesoft.com/downloads/mule-runtime/4.2/secure-properties-tool.jar](https://docs.mulesoft.com/downloads/mule-runtime/4.2/secure-properties-tool.jar)


#### For the Poller setup

When the Metrics Framework is setup to **poll** periodically to collect the data, the credentials for the **Anypoint Account User**, are embedded into the security properties file located: 

`src/main/resources/properties/secure/app-dev.yaml`

The following values should be encrypted using this technique within the ' **`src/main/resources/properties/secure/app-dev.yaml`** ' file.

*   **orgId**
*   **username**
*   **password**
*   <Other connected system credentials such as Splunk, Elk, Confluence, BitBucket, Jira, Jenkins if being used>

### Securing the SFDC Credentials

This should use the same technique as the **Anypoint Credentials**, except that the **Salesforce Account** credentials are configured in the following locations depending on the invocation approach:

#### **For the Poller setup:**

*   These are specified in the '**Runtime Manager'** properties when the application is deployed.  The values to be set in Runtime Manager should be secured with the following format:
  *   secure::**value**
*   However, they need to be correctly escaped when adding to the properties view in Runtime Manager: e.g.
  *   secure\\:\\:**value**
*   The following properties need to be specified:
  *   **sfdc.password**
  *   **sfdc.username**
  *   **sfdc.securityToken**

#### For the '/loader' API Invocation:

*   These are specified in the **payload** of the loader request
*   As these are sent over HTTPS - they are Non Encrypted Username, Password and Token ID. (Currently)


# Setting Up Salesforce analytics
## What to do with the data now it's available

Once the data is injected into **Salesforce Einstein Analytics** - The following steps will show you how to configure Einstein Analytics to clean, prepare and view the data.

Once the **Anypoint Metrics Accelerator** application is deployed and polling data, as per the above instructions, it will inject the data into the **Salesforce Analytics** dataset for further processing and visualisation.

**NOTE** : One of the steps below should be carried out during the installation and testing of the **Metrics Accelerator** application connectivity to **SFDC-Einstein Analytics** (SFDC-EA).  This is the step which creates the empty **Analytics Application** ready to have data injected.

## Prerequisites

To complete these steps you will need:

*   An access account to the **Salesforce** system
*   The account must have permissions/access to **Analytics Studio** application within Salesforce
*   The account must have permissions to **create** **Applications** and **Dashboards** within Analytics Studio.

There are various **Free Salesforce Analytics Trailheads** available to teach the basics and fundamentals of Salesforce Einstein Analytics:

*   [https://trailhead.salesforce.com/en/content/learn/trails/wave\_analytics\_enable\_and\_produce](https://trailhead.salesforce.com/en/content/learn/trails/wave_analytics_enable_and_produce)

##Process of setting up SFDC-EA

You will need your user account with access to a Salesforce Einstein Analytics account

The following are required in these instructions to configure the deployment parameters

*   SDFC-EA - Application Name (created below)
*   SFDC-EA - Username & Password credentials
*   SFDC-EA - Security Token (created/obtained below)

### Setup the empty EA Application

This will create an empty application in SFDC-EA to inject data into.  

*   From within your SDFC Account - select the "**Analytics Studio**" application
*   Select the '**Create**' button and select '**App**' option
*   NOTE: I you do not see the '**App**' item in your '**Create**' menu - contact the **system administrator** to provide you with the correct level of access.
*   Select '**Create Blank App**' then select '**Continue**'
    Give the application a meaningful name (from the    instructions, this was expected to be:
    *   **IPAAS_Anypoint_Metrics_App**
*   The Application is now created and ready to have data injected into it.
*   In order to configure the Metrics Application - you will also need the next value: the **SFDC EA Security Token**

### Acquiring the Security Token to call SFDC-EA externally

In order to configure the **Metrics Accelerator SFDC App** to inject the data into the SFDC EA Application from an external source, you will need a '**Security Token**' which is acquired from your SFDC EA Account and allows external API calls to the APIs exposed within SFDC-EA Applications (which we will be implicitly creating below)

If you do not already have one (because we will be resetting the existing one which will impact current users if there are any) then use the existing Security Token.  Otherwise, follow the steps to create/reset the token for use by the Metrics application.

*   From your login screen within SFDC-EA, select the Settings under your User:
*   From the Settings screen, select the **"My Personal Information"** menu item, then the **"Reset My Security Token"** option
*   Select the **"Reset Security Token"** button - which will then Email you a new Security Token to the account owner.

The **security token** in the Email should be used to configure the    configuration for "**sfdc.securityToken=<YOUR SFDC EA SECURITY TOKEN>**" in the Runtime Settings.

*   At this point, revert back to the setup and ensure data is collected correctly and able to be injected into the SFDC Instance.  This can be checked by looking at the logs in the Mule Application, but also checking in your "SDFC-EA Data Manager" for any newly 'uploaded' Datasets.

### Configure the DataSets and processing Recipes

NOTE: A **Recipe** is an SFDC-EA term used to perform actions on a dataset to produce another dataset

First we need to create a recipe which will clean up and correctly format the Dataset which is automatically uploaded from the **Metrics Accelerator** application above. 

The current issue is that the **Metrics Accelerator** provides a name-value pair of measures, but the 'values' are a mixture of both numeric and alpha-numeric values.  In order for SFDC-EA to visualise the metrics, we will extract all of the numeric ones into a clean dataset which is correctly setup as a '**Measure**' in EA which can then be plotted, added to an algorithm or represented in a widget.

**NOTE**: Although this section explains 'one' way of manipulating and displaying the raw data from the Mulesoft Metrics Accelerator application, there are countless other ways which can be used to transform, manipulate ad visualise the same data.  This is just one solution to get a basic Dashboard up and running within SFDC-Einstein Analytics.

This section is to purely utilise the data in a rudimentary form, which can then be expanded to requirement.

**NOTE**: There will be future extensions to the capability of the Metrics Application which can facilitate finer grain metrics around each API.  These **may not** be captured in this high level introduction as the capabilities evolve, but will use similar techniques provided by SFDC EA.

### Clean the bulk dataset - Recipe

This first Recipe will correctly tag the '**value**' measurement in the dataset to be a '**Measure**' type - which can be used to plot and calculate interesting visuals.

We will create a new dataset from the original ( ' **IPAAS_Anypoint_Metrics_DataSet**' ) and call it '**IPAAS_Anypoint_Clean_Metrics_DataSet**'

The Recipe can then be scheduled to run at periodic times to coincide with the frequency of the data being injected from the Metrics Application.

*   Within SFDC-EA - login and select the '**Data Manager**' from the top cog
*   Select '**Dataflows & Recipes**' from the main menu
*   Select the '**Recipes**' tab on the right panel:
*   Select the blue '**Create Recipe**' button
*   Select **'Select Data'** and select the dataset which the Metrics application has injected ('**IPAAS_Anypoint_Metrics_DataSet** ')
*   Select '**Next**' and you will be presented with the graphical '**Recipe**' editor screen with your dataset icon

#### Make the 'value' a proper measure which can be displayed

*   Hover over the icon and select the '**+**' next to the dataset and select '**Transform**' from the menu
*   The dataset rows and columns will be displayed
*   Select the '**value**' column header 
*   Then select the '**Columns**' tab
*   Select the '**value**' row from the table and then select the 'Dimension To' dropdown in the toolbar and select '**Measure'**
*   This will display a panel to configure the conversion - Ensure the '**Original Column**' option is selected for the '**value**' column - and select '**Apply**'
*   You will now see your data columns with a '**Measure**' type for the Value column.
*   Drag the title bar down from the top of the screen - to expose the image underneath with the source and transform added.

#### Clean the 'name' of the metrics to a shorter format

*   Now add a new column which contains a '**shorter name**' than the original '**Name**' column by tidying it up a little.
*   Select the '**+**' to the right on he last transform and add a new '**Transform**' node.
*   Click the '**Fx**' menu item and select '**Custom Formula**'
*   In the custom formula box - paste the following text:

```
replace(
replace(
replace(
replace(
replace(
name, "Design Center", ""),
"API Manager API Instances","APIs"),
" Total", ""),
"API Manager ",""),
"CloudHub ","")
```

*   In the **Output Type** - select '**Text**'
*   In the '**Show Results In**' - select '**New Column (and Keep Original)**'
*   In the Column Label - type '**shortName**'
*   Click '**Apply**' and a new column will be visible with a more compact name (ready for displaying)

#### Output the dataset to a clean dataset

*   Now add an output node to this recipe flow to ensure we generate an output dataset
*   Select the '**+**' sign to the right of the '**Transform**' node and select '**Output**'
*   In the '**Output**' configuration enter:
    *   Dataset Display Name: '**IPAAS\_Anypoint\_Clean\_Metrics\_DataSet**'
    *   Dataset API Name: '**IPAAS\_Anypoint\_Clean\_Metrics\_DataSet**'
    *   App Location: ' **IPAAS\_Anypoint\_Metrics\_App** '. (Note this is the App you created earlier)
*   Press '**Apply**'

#### Extract the Enumerations Dataset which were lost

Because we changed the value field into a measure, this will only take numeric fields.  However some value fields were textual fields so we should create a new DataSet with these field from the source Dataset

*   Add an additional flow to the Recipe which will extract and output the 'Enumerated' non numeric values from the original Values field.
*   The aim is to extract only the fields which have non-numeric 'values' - these are quite limited in the current results injected from the Metrics Accelerator application:  
    *   Runtime Versions used
    *   API Manager Policies Used

From the Visual Recipe Editor:

  *   Select the 'branch symbol' sign next to the Data Source '**IPAAS\_Anypoint\_Metrics\_DataSet**' and select '**Filter**'
  *   In the filter configuration panel - select the "**+**" sign
  *   Select '**Name**' and select the two items from the list:
        *   API Manager Policies Used
        *   Cloudhub Runtime Versions Users
  *   Select '**Apply**'
  *   Review the Recipe flows image.
  *   Now output the filtered data to a new Dataset called "**IPAAS\_Anypoint\_Enumerations\_DataSet"**
  *   Click the "**+**" to the right of the Filter and add an '**Output**'
  *   Configure and save the output  
  *   Press '**Apply**'
  *   Then '**Save**' the Recipe and provide it a name: e.g.
      *   '**IPAAS\_Metrics\_Cleanup\_Recipe**'
  *   Traverse back the the Data Manager (click the button saying '**Back to Data Manager**' in the top right corner)
  *   Now we will schedule the Recipe to run periodically.


```
NOTE: You can run this Recipe now if you wanted - this will produce 2 extra Datasets from the original Dataset: 
*   Click **'Save and Run**' for the recipe to generate the two output datasets from the last acquired Metrics data.
*   Click '**Back to Data Manager**'
```  

#### Schedule the recipe to run periodically on receipt of data from Metrics

Back in the Data Manager, view your **Recipes** (**Dataflows & Recipes,** then Recipes tab)

*   Click the line for the recipe you just created: '**IPAAS\_Metrics\_Cleanup\_Recipe**'
*   Select the arrow on the right end of the recipe line and select '**Schedule**'
*   Create a schedule which is aligned with your Data Collection '**cron**' job which is configured in the Metrics Accelerator application
*   e.g.  the default is collecting data at midnight every day so the following schedule will process the data after it has been uploaded to SFDC EA
*   You may want to '**Run Now**' and monitor the Data creation in the Data Manager 'Monitor' window.
*   A clean data set should now be available in Data Manager under the '**Data**' section
*   **NOTE**: If the Scheduled is setup as per the documented Schedule in the Metrics Accelerator App - then the following schedule should run the clean-up on the input data soon after it arrives:

### Create a Dashboard within your application

Dashboards allow you to present your data in different ways using one of the many widgets available within Einstein Analytics.  Create an empty dashboard then add elements of the data as you see fit

In **Analytics Studio:**

*   select '**All Items**' then
*   select the '**Apps**' tab and
*   select your App from the list ( "**IPAAS\_Anypoint\_Metrics\_App**")

This will open up all the stats for this application, including the associated DataSets (which we have already created and connected this application) any Dashboards connected with the Application, and any '**Lenses**' which are views onto the dataset.

*   Select the '**DASHBOARDS**' tab
*   Select '**Create**' then '**Dashboard**'
*   Then '**Blank Dashboard**' for the sake of this setup.
*   You'll see a dashboard blank canvas ready to be populated with your widgets.
*   Click on the Dashboard Name ("called "New dashboard" in the top left and give a name e.g. "**IPAAS Platform Usage**")

### Add some Dashboard Content

*   Drag the graph icon onto the dashboard
*   Select '**Chart**' and select the '**IPAAS\_Anypoint\_Clean\_Metrics\_Dataset**"
*   You can then edit the data from the Query you want to view: e.g:
    *   Bar Length - select "Sum of Value"
    *   Bars - **businessGroup** then name then **environmentType**
    *   Filter- **name** 'Equals' ( **CloudHub vCores Available Total** or **CloudHub vCores Total** or  **CloudHub vCores Used Total**)
    *   We can also filter all Business Groups which are not using any vCores
        *   Filter : **value** 'Not Equal' **0**
*   We then have a graph which looks concise and shows the number of vCores used in each environment, and how many they have left to use
*   Click '**Done**' to add this graphic to the dashboard
*   Once added - you can modify the graphic parameters accordingly

### Configure Historic Data Set and enhance the Recipe to populate it

Go to Data Manager and create a new empty historic Data Set to push data into as it arrives from the Anypoint Metrics Framework

*   Open "Data Manager"
*   Select **Create** then **New DataSet**
*   Upload the blank DataSet file found in `src/main/resources/sfdc/blank_dataset.csv`  - which is an empty replica of the CSV returned from Anypoint (Except a few samples rows of data)
*   Call the DataSet:  **IPAAS\_Anypoint\_Historic\_DataSet**
*   Open the **Recipe** we previously created and enhance it to push each data set into the historic dataset
*   Open "**Dataflows & Recipes"** → "**Recipes**" and open the "**IPAAS_Metrics_Cleanup_Recipe**"
*   From the output of the '**Transform**' to clean the names - select to branch off to a new '**Append**" Node.
*   In the "**Select Input Data to Append**" select "**IPAAS_Anypoint_Historic_DataSet**" and then "**Next**"
*   You'll see a sample preview of the output - select '**Apply**'
*   Now send the output back to the Historic Dataset - Rearrange the nodes as necessary on the diagram for ease of reading:
*   Select the "**+**" next to the '**Append**' node and add an Output Node
*   Change the 4 fields  below (Ensure you get the names correct for the DataSet and API)
   * Edit Name: **Output to Historic DataSet**
   * Dataset Display Label: **IPAAS_Anypoint_Historic_DataSet**
   * Dataset API Name: **IPAAS_Anypoint_Historic_DataSet**
   * APP Location: **IPAAS_Anypoint_Metrics_App**
*   Select '**Apply**' then Save
*   From the '**Dataflows and Recipes**' Recipe tab - you can now run the Recipe manually if required.  However, this will run automatically on the scheduled time slot.

### Extracting and migrating Dashboards

When Dashboards are in development and test, they are developed in a UAT Environment.  Although these are fully production ready, and represent the real production data, there may come a point where the Dashboard and configurations need to be promoted to Production environments.

Within **Salesforce Einstein Analytics**, there is a lot of setting up and delicate tweaking of the various dashboard components (above) which result in a final dashboard which is easily consumable.  However, Einstein Analytics does not allows a direct export of the settings to then import into a higher level (or different) environment.  However, Salesforce does provide an administrative tool called 'Workbench' which allows this to be performed by administrators.

A good step-by-step guide to extract the Dashboard in the correct format can be found here: [https://www.salesforceblogger.com/2020/06/15/uncovering-deployment-techniques-for-einstein-analytics/](https://www.salesforceblogger.com/2020/06/15/uncovering-deployment-techniques-for-einstein-analytics/)

The following provides examples/steps based on the configuration and Dashboard/Dataset names above.

*   Login to the Workbench for te required UAT Instance: [https://workbench.developerforce.com/login.php](https://workbench.developerforce.com/login.php)
*   Select '**Environment : Sandbox**' version '**48.0**' ( **NOTE: Maybe different according to customer Salesforce Org)**
*   Login/authenticate with the same account as the Dashboard is created as
*   Select '**Migration**' → '**Retrieve**'
*   For the '**Unpackaged manifest**'  - upload the following XML Manifest (you may need to enhance to cover all aspects required to be exported)
*   The Manifest contains all the required elements of the dashboard as shown below:

```
<?xml version="1.0" encoding="UTF-8"?>
<Package xmlns="http://soap.sforce.com/2006/04/metadata">
    <types>
        <members>IPAAS_Anypoint_Metrics_App</members>
        <name>WaveApplication</name>
    </types>
    <types>
        <members>IPAAS_Platform_Usage</members>
        <name>WaveDashboard</name>
    </types>
    <types>
        <members>IPAAS_Anypoint_Metrics_DataSet</members>
        <name>WaveDataset</name>
    </types>
    <types>
        <members>IPAAS_Anypoint_Clean_Metrics_DataSet</members>
        <name>WaveDataset</name>
    </types>
    <types>
        <members>IPAAS_Anypoint_Enumerations_DataSet</members>
        <name>WaveDataset</name>
    </types>
    <types>
        <members>IPAAS_Metrics_Cleanup_Recipe</members>
        <name>WaveRecipe</name>
    </types>
    <types>
        <members>IPAAS_Platform_Usage</members>
        <name>WaveXmd</name>
    </types>
    <version>49.0</version>
</Package>
```  

*   Select '**Single Package**' and '**Next'** 
*   Select '**Retrieve**' and ensure there are no errors in the export.
*   The select the '**Download ZIP File**' to extract as a Zip File for the import process.
*   Importing is the opposite to exporting - but selecting the '**Migration**' → '**Deploy**' option instead.

This extracted file will then be able to be imported into your next Einstein Analytics environment.
