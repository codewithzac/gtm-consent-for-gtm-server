___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "GTM Consent for GTM Server (Server)",
  "description": "Get the status of standard GTM consent types from a Web container to send to GTM Server via GA4.",
  "containerContexts": [
    "SERVER"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "eventVariable",
    "displayName": "Consent State Event Variable",
    "simpleValueType": true,
    "defaultValue": "consent_state",
    "help": "Which event data variable contains the JSON.stringify()\u0027ed version of the consent object?",
    "alwaysInSummary": true
  },
  {
    "type": "SELECT",
    "name": "consentType",
    "displayName": "GTM Consent Type",
    "macrosInSelect": false,
    "selectItems": [
      {
        "value": "ad_storage",
        "displayValue": "Ad Storage"
      },
      {
        "value": "ad_user_data",
        "displayValue": "Ad User Data"
      },
      {
        "value": "ad_personalization",
        "displayValue": "Ad Personalization"
      },
      {
        "value": "analytics_storage",
        "displayValue": "Analytics Storage"
      },
      {
        "value": "functionality_storage",
        "displayValue": "Functionality Storage"
      },
      {
        "value": "personalization_storage",
        "displayValue": "Personalization Storage"
      },
      {
        "value": "security_storage",
        "displayValue": "Security Storage"
      }
    ],
    "simpleValueType": true,
    "alwaysInSummary": true,
    "help": "Select the GTM consent type to return for this variable"
  }
]


___SANDBOXED_JS_FOR_SERVER___

// GTM template constants
const getEventData = require('getEventData');
const JSON = require('JSON');
const getType = require('getType');

// Set up consent constants
const consentState = getEventData(data.eventVariable);
const consentType = data.consentType;

// If consent exists and is JSON.parse'able, return the value of the selected consent type
if (consentState) {
  const consentJSON = JSON.parse(consentState);
  if (getType(consentJSON) == 'object') {
    return consentJSON[consentType];
  }
}

// Variables must return a value
return false;


___SERVER_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "read_event_data",
        "versionId": "1"
      },
      "param": [
        {
          "key": "eventDataAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 28/12/2024, 19:49:18


