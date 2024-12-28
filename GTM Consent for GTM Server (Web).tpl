___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "GTM Consent for GTM Server (Web)",
  "categories": [
    "UTILITY"
  ],
  "description": "Get the status of standard GTM consent types from a Web container to send to GTM Server via GA4.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "GROUP",
    "name": "enabledConsentTypes",
    "displayName": "Consent Types",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "LABEL",
        "name": "description",
        "displayName": "Choose which GTM consent types you wish you query. This should match the consent types configured in your Consent Initialization tag."
      },
      {
        "type": "CHECKBOX",
        "name": "ad_storage",
        "checkboxText": "Ad Storage",
        "simpleValueType": true
      },
      {
        "type": "CHECKBOX",
        "name": "ad_user_data",
        "checkboxText": "Ad User Data",
        "simpleValueType": true
      },
      {
        "type": "CHECKBOX",
        "name": "ad_personalization",
        "checkboxText": "Ad Personalization",
        "simpleValueType": true
      },
      {
        "type": "CHECKBOX",
        "name": "analytics_storage",
        "checkboxText": "Analytics Storage",
        "simpleValueType": true
      },
      {
        "type": "CHECKBOX",
        "name": "functionality_storage",
        "checkboxText": "Functionality Storage",
        "simpleValueType": true
      },
      {
        "type": "CHECKBOX",
        "name": "personalization_storage",
        "checkboxText": "Personalization Storage",
        "simpleValueType": true
      },
      {
        "type": "CHECKBOX",
        "name": "security_storage",
        "checkboxText": "Security Storage",
        "simpleValueType": true
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

// GTM template constants
const copyFromDataLayer = require('copyFromDataLayer');
const isConsentGranted = require('isConsentGranted');
const JSON = require('JSON');

// Set up consent constants
const eventName = copyFromDataLayer('event');

// Read consent state for selected consent types into consentObj
// Don't attempt to read current consent state at consent initialisation - this causes errors!
let consentObj = {};
if (eventName != 'gtm.init_consent') {
  if (data.ad_storage) {
      consentObj.ad_storage = isConsentGranted('ad_storage') ? 'granted' : 'denied';
  }
  if (data.ad_user_data) {
      consentObj.ad_user_data = isConsentGranted('ad_user_data') ? 'granted' : 'denied';
  }
  if (data.ad_personalization) {
      consentObj.ad_personalization = isConsentGranted('ad_personalization') ? 'granted' : 'denied';
  }
  if (data.analytics_storage) {
      consentObj.analytics_storage = isConsentGranted('analytics_storage') ? 'granted' : 'denied';
  }
  if (data.functionality_storage) {
      consentObj.functionality_storage = isConsentGranted('functionality_storage') ? 'granted' : 'denied';
  }
  if (data.personalization_storage) {
      consentObj.personalization_storage = isConsentGranted('personalization_storage') ? 'granted' : 'denied';
  }
  if (data.security_storage) {
      consentObj.security_storage = isConsentGranted('security_storage') ? 'granted' : 'denied';
  }
}

// Return
return JSON.stringify(consentObj);


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "access_consent",
        "versionId": "1"
      },
      "param": [
        {
          "key": "consentTypes",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_user_data"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_personalization"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "analytics_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "functionality_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "personalization_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "security_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "read_data_layer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedKeys",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "keyPatterns",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "event"
              }
            ]
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

Created on 2021/6/21 12:59:49


