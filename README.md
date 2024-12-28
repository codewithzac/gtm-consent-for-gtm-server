# gtm-consent-for-gtm-server
Variable templates to help pass consent signals to GTM server side.

## Introduction
These two templates help pass defined consent states from a GTM Web container to a GTM Server container, where you are able to use the consent signals to determine whether or not you should fire tags. Unfortunately, GTM Server containers don't enjoy the same support for consent signals as GTM Web containers; these templates are a bit "hacky" as a result.

When using the GA4 tag from GTM Web with the GA4 client from GTM Server, there *are* consent signals available in form of two event data parameters: **x-ga-gcd** and **x-ga-gcs**. The former has changed formats multiple times, the latter is very limited in the information it provides - and neither are well-documented. Instead of using these parameters, we'll do the following:

1. Use a GTM Web variable template to collect consent state using the `isConsentGranted` API
2. Use the GA4 tag to send the `JSON.stringify()`'ed consent state to the GTM Server container
3. Use a GTM Server variable template to read the consent state and make it available in server variables

## Download Template files
Either:

- Click the <> Code button above, select Download ZIP, or
- Go to the latest release in Releases on the right, then download the latest Source code (zip)

Extract the ZIP file, then find the `GTM Consent for GTM Server (Web).tpl` and `GTM Consent for GTM Server (Server).tpl` files within.

## Web Template
### Installation
1. Go to your GTM Web container
2. Navigate to the **Templates** menu, then click the **New** button in the Variable Templates box
3. Click the **...** menu at the top-right, then select **Import**
4. Choose the `GTM Consent for GTM Server (Web).tpl` file from before, then wait for it to import
5. Click the **Save** button at the top-right, then click **X** at the top-left to return to the main GTM interface

### Configuration
First, review your existing Consent Initialisation tag to see which of the standard GTM consent types you're currently using - then:
1. Navigate to the **Variables** menu, then click the **New** button in the User-Defined Variables section
2. Give the variable a name - e.g., `Consent State`
4. Click into **Variable Configuration**, then select **GTM Consent for GTM Server (Web)** from the Custom Templates section
5. In the **Consent Types** section, check the checkbox for each of the GTM consent types you're using
6. Click the **Save** button at the top-right, then click **X** at the top-left to return to the main GTM interface

## Google Analytics
These instructions assume a few things - if any of these aren't true for you, consider updating your config to match!
- You have a **Google Tag** and several **Google Analytics: GA4 Event** tags
- These tags are already configured to use Configuration settings variables and Event settings variables
- These tags are already successfully sending data to the GTM Server container

### Event Settings Variable
You need to add one mapping to your Event Settings Variable(s) that you use with your GA4 tags. For each variable:
1. Find and click into the variable
2. Add a mapping as follows - the value is the variable name:

| Event parameter | Value |
| --------------- | ----- |
| consent_state | {{Consent State}} |

### GA4 Consent Settings
For each of the Google Analytics tags, you may want to ensure that no Additional Consent has been required. If it has, and that consent type is denied by the end user - *nothing* will be sent to the GTM Server container!
1. Navigate to the **Tags** menu, then click the **Shield** icon next to the New button
2. Review the **Additional consent** settings for each of the Google Analytics tags
3. Consider setting each tag to **No additional consent required** in the Additional consent checks section

## Server Template
### Installation
1. Go to your GTM Server container
2. Navigate to the **Templates** menu, then click the **New** button in the Variable Templates section
3. Click the **...** menu at the top-right, then select **Import**
4. Choose the `GTM Consent for GTM Server (Server).tpl` file from before, then wait for it to import
5. Click the **Save** button at the top-right, then click **X** at the top-left to return to the main GTM interface

### Configuration
Unlike the web container, you need to create individual variables for each of the GTM consent types you are using - repeat these steps as many times as you need:
1. Navigate to the **Variables** menu, then click the **New** button in the User-Defined Variables section
2. Give the variable a name - e.g., `Analytics Storage`
4. Click into **Variable Configuration**, then select **GTM Consent for GTM Server (Server)** from the Custom Templates section
5. In the **Consent State Event Variable** section, enter the event variable name that has a `JSON.stringify()`'ed version of the consent state. The default is fine if following these instructions.
6. In the **GTM Consent Type** section, choose the consent type for this variable (typically the same as the name of the variable)

## Blocking Tags
The easiest way to block tags based on consent using these variables is to create "negative" triggers that you use as exceptions. For example, to block the **Google Analytics: GA4** tag if the user has opted out of analytics:

### Triggers
1. Navigate to the **Triggers** menu, then click the **New** button
2. Give the trigger a name - e.g., `Analytics Storage Denied`
3. Click into **Trigger Configuration**, then select **Custom**
4. Select **Some Events**
5. In the first dropdown, choose the **Analytics Storage** variable
6. In the second dropdown, choose **equals**
7. In the text box, enter `denied`
8. Click the **Save** button at the top-right, then click **X** at the top-left to return to the main GTM interface

### Tag Configuration
1. Navigate to the **Tags** menu, then select the **Google Analytics: GA4** tag
2. In the Triggering section, click the **pencil** icon to edit, and then the **plus** icon to the right of Exceptions
3. Find and select the **Analytics Storage Denied** trigger
4. Click the **Save** button at the top-right, then click **X** at the top-left to return to the main GTM interface

## Transformations *(optional)*
The final step is excluding the consent state event data variable from the event payload - you may want to do this to prevent tags from accessing the raw consent state variable. This step is completely optional, and won't change how consent works:
1. Navigate to the **Transformations** menu, then click the **New** button
2. Give the transformation a name - e.g., `Exclude consent_state`
3. Click into **Transformation configuration**, then select **Exclude parameters**
4. Click the **Add Row** button
5. In the **Parameters to Exclude** box, enter `consent_state` *(or whatever name you gave the parameter)*
6. Click the **Save** button at the top-right, then click **X** at the top-left to return to the main GTM interface
