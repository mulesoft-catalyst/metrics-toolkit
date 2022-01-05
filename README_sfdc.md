Introduction
============

This README introduces how to configure the SFDC loader of the Metrics Framework to inject data into your Tableau CRM Dashboards.

Tableau CRM was previously named Einstein Analytics

This page highlights the steps required to receive and visualise the Metrics Data within **Tableau CRM** and allow the custom creation of dashboards

# Setting Up Salesforce Tableau CRM


The following steps will show you how to configure Tableau CRM to clean, prepare and view the data.


## Prerequisites

To complete these steps you will need:

*   An account with access to the **Salesforce** system
*   The account must have permissions/access to **Analytics Studio** application within Salesforce
*   The account must have permissions to create**Applications** and **Dashboards** within Analytics Studio.

There are various free [Trailhead](https://trailhead.salesforce.com/en/content/learn/trails/wave_analytics_enable_and_produce) Modules available to teach the basics and fundamentals of Salesforce Tableau CRM

The following are required to configure the deployment parameters

*   SDFC-EA - Application Name (created below)
*   SFDC-EA - Username & Password credentials
*   SFDC-EA - Security Token (created/obtained as described [here](https://help.salesforce.com/s/articleView?id=sf.user_security_token.htm&type=5))

### Setup the empty Tableau CRM Application
This will create an empty application in SFDC to inject data into. This application name is required before attempting to publish any analytics data to Salesforce.

*   From within your SFDC Account - select the **Analytics Studio** application
*   Select **Create** > **App** > **Create Blank App** > **Continue**. Give the application a meaningful name
*   The Application is now created and ready to have data injected into it.
*   Configure the metrics toolkit with your newly created application details, security token and credentials. Deploy and run the metrics toolkit, and trigger the loader to upload data into a new dataset


### Configure the DataSets and processing Recipes
**NOTE**: Although this section explains one way of manipulating and displaying the raw data from the Metrics Toolkit, there are numerous other, potentially better, approaches which can be taken. This document describes one possible solution to get a basic Dashboard up and running within SFDC-Einstein Analytics.

The **Metrics Toolkit** provides a name-value pairs of measures, but the values are a mixture of both numeric and alpha-numeric values. In order for Tableau CRM to visualise the metrics, all values must be numeric. A recipe is created to transfrom numeric values into measures, and store the output in a clean dataset which can be utilised in dashboards. 

### Clean the bulk dataset - Recipe

This Recipe will transform the **value** column in the dataset to be a **Measure** type
The Recipe can be scheduled to run at periodic times to coincide with the frequency of the data being injected from the Metrics Toolkit.

*   From **Data Manager** select **Dataflows & Recipes** > **Recipes** > **Create Recipe** 
*   Select **Add Input Data** and choose the dataset which the Metrics toolkit has uploaded
*   Select **Next** and you will be presented with the **Recipe** editor 

#### Tranform the value from Dimension to Measure

*   Add a **Transform** after the data source, the dataset rows and columns will be displayed
*   Select the **value** column and click **Dimension to**. Select **Measure** from the drop down menu
*   This will display a panel to configure the conversion - select **Apply**

#### Output the dataset to a clean dataset

*   Add an output node to the recipe flow
*   Provide a meaningful name and API name. Select the previously created application as the app location
*   Press **Apply**

#### (Optional) Extract the Enumerations Dataset

Transforming the value field into a measure, preserves only take numeric fields. However some value fields are textual fields and in order to preserve a new DataSet can be created
From the Visual Recipe Editor:

  *   Add a new branch next to the Data Source and select **Filter**
  *   In the filter configuration panel select the "**+**" sign.
  *   (Currently) two fields have non-numeric values. Select **Name** and select the two items from the list:
        *   API Manager Policies Used
        *   Cloudhub Runtime Versions Users
  *   Select **Apply**
  *   Output the filtered data to a new Dataset
  *   Save the Recipe and provide it a name

#### (Optional) Schedule the recipe to run periodically on receipt of data from Metrics

Data Manager provides the option to schedule recipes if required. See [here](https://help.salesforce.com/s/articleView?id=sf.bi_integrate_job_recipe_schedule.htm&type=5) 


### (Optional) Configure Historic Data Set and enhance the Recipe to populate it

In order to show data over time, an additional historic dataset is created.
**Note** - This approach may not be best practice and you should speak to your Salesforce admins before storing large amounts of data in Tableau CRM

*   In "Data Manager" select **Create** then **New DataSet**
*   An example DataSet file is provided in `src/main/resources/sfdc/blank_dataset.csv`  - which is a replica of the CSV returned from Anypoint containing a small number of samples rows of data
*   Provide the new DataSet with a name to differentiate it from the 'clean' dataset created by the recipe above
*   Open the previously created **Recipe**  and enhance it to push each data set into the historic dataset
*   From the output of the **Transform**, add a new branch to an **Append** Node
*   In the **Select Input Data to Append** select the historic DataSet
*   Add an **Output** after the **Append** node and configure this output to the historic DataSet
*   Select **Apply** then Save


### Create a Dashboard within your application

Dashboards allow you to present your data in different ways using one of the many widgets available within Tableau CRM. Create an empty dashboard then add elements of the data as you see fit

This section provides steps to configure a rudimentary dashboard, but users must invest time expanding to meet their own requirements

In **Analytics Studio**, select **All Items** > **Apps** tab and choose your App from the list 
This will open up all the stats for this application, including the associated DataSets (which we have already created and connected this application) any Dashboards connected with the Application, and any **Lenses** which are views onto the dataset.

*   Select the **Dashboards** tab > **Create** > **Dashboard** > **Blank Dashboard**
*   A blank canvas is displayed, ready to be populated with data visualisation widgets
*   Click on the Dashboard Name ("called "New dashboard" in the top left) and give it a name

### Add some Dashboard Content

*   Drag the graph icon onto the dashboard
*   Select **Chart** and select a created DataSet
*   You can then edit the data from the Query you want to view: e.g:
    *   Bar Length - select "Sum of Value"
    *   Bars - **businessGroup** then name then **environmentType**
    *   Filter- **name** Equals ( **CloudHub vCores Available Total** or **CloudHub vCores Total** or **CloudHub vCores Used Total**)
    *   We can also filter all Business Groups which are not using any vCores
        *   Filter : **value** Not Equal **0**
*   We then have a graph which looks concise and shows the number of vCores used in each environment, and how many they have left to use
*   Click **Done** to add this graphic to the dashboard
*   Once added - you can modify the graphic parameters accordingly