-- Detect AccessDenied events for restricted IAM users
fields @timestamp, eventName, eventSource, userIdentity.userName, sourceIPAddress
| filter errorCode = "AccessDenied"
| sort @timestamp desc
| limit 100
