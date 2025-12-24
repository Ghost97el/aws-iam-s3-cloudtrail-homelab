# AWS IAM, S3 & CloudTrail Security Homelab

## Overview
This project demonstrates a hands-on AWS cloud security homelab focused on
IAM least-privilege enforcement, secure S3 data access, and audit visibility
using AWS CloudTrail and CloudWatch Logs Insights.

The lab simulates a real-world scenario where a restricted application user
is granted read-only access to a single S3 bucket while all actions are fully
logged and auditable.

---

## Objectives
- Implement IAM least privilege
- Secure sensitive data in Amazon S3
- Validate permissions through AccessDenied testing
- Audit activity using AWS CloudTrail
- Analyze events using CloudWatch Logs Insights

---

## Architecture

### IAM Identities
| Identity | Purpose | Access Level |
|--------|--------|-------------|
| Root user | Account & billing | Never used for daily work |
| Ghost-Admin | Administrative setup | Full access |
| ghost-app-reader | Application user | Read-only, scoped |

---

### S3 Buckets
| Bucket | Purpose | Access |
|------|--------|--------|
| ghost-secret-data-01 | Sensitive data | Read-only for app user |
| Other buckets | Not allowed | Explicitly denied |

---

## IAM Policy Design
The IAM policy enforces strict least privilege:
- Allowed actions:
  - s3:ListAllMyBuckets (console visibility)
  - s3:ListBucket (specific bucket)
  - s3:GetObject (read-only access)
  - cloudtrail:LookupEvents (audit visibility)
- Explicitly blocked:
  - Object uploads
  - Bucket deletion
  - Access to other buckets

---

## Validation & Testing
- Upload attempts → AccessDenied
- Access to non-approved buckets → AccessDenied
- Read-only object access → Allowed
- All activity logged in CloudTrail

---

## Logging & Monitoring
- AWS CloudTrail enabled
- Logs stored centrally
- Queries executed using CloudWatch Logs Insights

Example query:
```sql
fields @timestamp, eventName, userIdentity.userName, sourceIPAddress
| sort @timestamp desc
| limit 20
