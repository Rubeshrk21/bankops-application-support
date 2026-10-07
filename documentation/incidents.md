# BankOps Incident Management

## 1. Purpose

This document records simulated application support incidents identified during the BankOps Application Support project.

The purpose is to demonstrate a structured approach to incident detection, investigation, evidence collection, service restoration, verification, and root cause analysis.

This is a personal simulated project and does not represent production banking incidents.

---

## 2. Incident Management Approach

The following process is used for application support incidents:

1. Detect the incident
2. Confirm the issue
3. Collect evidence
4. Identify affected transactions or users
5. Check application logs
6. Check database records
7. Check application and database connectivity
8. Isolate the likely failure area
9. Apply a workaround or corrective action when appropriate
10. Verify service recovery
11. Document the incident
12. Identify the root cause or list remaining investigation areas

---

## 3. Incident INC-001 — Transaction Failed with DB_TIMEOUT

### 3.1 Incident Summary

Transaction `TXN10004` failed while being processed by the BankOps application.

The application log reported a `DB_TIMEOUT` error.

### 3.2 Incident Details

| Field | Details |
|---|---|
| Incident ID | INC-001 |
| Transaction ID | TXN10004 |
| Error Code | DB_TIMEOUT |
| Severity | High |
| Status | Investigated |
| Environment | Simulated |
| Affected Component | Application / Database interaction |

### 3.3 Detection

The incident was identified during application log monitoring.

The application log contained:

2026-10-01 10:30:01 INFO Transaction TXN10004 started for account 2004
2026-10-01 10:30:02 ERROR Transaction TXN10004 failed with DB_TIMEOUT

The application error table also contained a corresponding error record.

### 3.4 Database Investigation

The transaction record was checked using SQL.

The investigation confirmed:

* Transaction ID: `TXN10004`
* Account ID: `2004`
* Transaction type: `TRANSFER`
* Amount: `4500.00`
* Transaction status: `FAILED`
* Error code: `DB_TIMEOUT`

The related account and customer information was also checked.

The account belonged to customer `1004`, and the account status was `ACTIVE`.

### 3.5 Application Error Investigation

The `application_errors` table contained:

Error ID: 5001
Transaction: TXN10004
Error Code: DB_TIMEOUT
Severity: HIGH
Error Message: Database connection timeout while processing transaction

### 3.6 Investigation Timeline

| Time                    | Activity                                      |
| ----------------------- | --------------------------------------------- |
| 10:30:01                | Transaction TXN10004 started                  |
| 10:30:02                | Application reported DB_TIMEOUT               |
| After detection         | Transaction record checked in MySQL           |
| After transaction check | Related account and customer checked          |
| After database check    | Application error record reviewed             |
| Final stage             | Evidence correlated between logs and database |

### 3.7 Investigation Flow

The investigation followed this sequence:

Application Log
      |
      v
Identify TXN10004
      |
      v
Check Transaction in MySQL
      |
      v
Check Account and Customer
      |
      v
Check application_errors
      |
      v
Correlate evidence
      |
      v
Identify database connection timeout

### 3.8 Finding

The available evidence confirms that the transaction failed because the application encountered a database connection timeout while processing the transaction.

The evidence does not prove that the MySQL server itself was completely down.

Therefore, the investigation should not incorrectly conclude that the database server was down.

### 3.9 Root Cause Status

Confirmed failure: Database connection timeout.

Underlying root cause: Not conclusively determined from the available simulated evidence.

Possible areas for further investigation would include:

* Database connectivity
* Connection availability
* Connection pool exhaustion
* Database resource utilization
* Network connectivity
* Query performance
* Database server logs

These are investigation areas and should not be presented as confirmed causes without supporting evidence.

### 3.10 Resolution and Verification

After identifying the failure, the transaction status and supporting evidence were reviewed to verify the incident condition.

In a real production environment, the support engineer would continue with the appropriate recovery procedure, such as retrying the transaction if permitted, restoring database connectivity, or escalating the database issue.

The important support principle is:

Never assume the root cause without evidence.

---

## 4. Incident INC-002 — Repeated DB_TIMEOUT Errors

### 4.1 Incident Summary

Repeated `DB_TIMEOUT` errors were detected in the application log.

The log monitoring script identified multiple database timeout errors and generated an alert when the number of `DB_TIMEOUT` entries exceeded the defined threshold.

### 4.2 Incident Details

| Field            | Details             |
| ---------------- | ------------------- |
| Incident ID      | INC-002             |
| Error Code       | DB_TIMEOUT          |
| Severity         | High                |
| Environment      | Simulated           |
| Detection Method | Log monitoring      |
| Status           | Under investigation |

### 4.3 Detection

The log monitoring script reported:

ERROR entries: 8
DB_TIMEOUT errors detected: 7
ALERT: Repeated DB_TIMEOUT errors require investigation.

The log also contained one `ACCOUNT_BLOCKED` error.

Therefore:

Total ERROR entries = 8

DB_TIMEOUT = 7
ACCOUNT_BLOCKED = 1

### 4.4 Affected Transactions in Application Logs

The repeated timeout pattern appeared in transactions including:

TXN10004
TXN10010
TXN10013
TXN10014
TXN10015
TXN10016
TXN10017

`TXN10013` was later retried and completed successfully.

### 4.5 Investigation

The investigation followed these steps:

1. Confirm repeated errors in `application.log`
2. Count occurrences of `DB_TIMEOUT`
3. Identify affected transaction IDs
4. Check corresponding database records
5. Review `application_errors`
6. Check database connectivity
7. Consider application, network, and database factors
8. Determine whether a common root cause can be proven

### 4.6 Important Evidence Limitation

The later simulated log entries from `TXN10013` through `TXN10017` were added to the application log for monitoring practice.

They were not added as corresponding transaction records in the MySQL database.

Therefore, the application logs and database records are not completely synchronized for these later simulated transactions.

This limitation is documented intentionally rather than treating missing database records as evidence of a production issue.

### 4.7 Findings

The monitoring data confirms that repeated `DB_TIMEOUT` errors occurred in the simulated application logs.

However, the available evidence does not conclusively identify the underlying root cause.

Further investigation would be required in a real environment.

Potential investigation areas include:

* Database server availability
* Network connectivity
* Database connection pool
* Database resource utilization
* Slow-running queries
* Application connection handling
* Database server logs

### 4.8 Root Cause Status

**Status: Not conclusively determined.**

The correct support approach is to continue collecting evidence rather than assigning an unsupported root cause.

### 4.9 Retry Observation

`TXN10013` demonstrated a successful retry:

2026-10-04 18:50:01 INFO Transaction TXN10013 started for account 2001
2026-10-04 18:50:03 ERROR Transaction TXN10013 failed with DB_TIMEOUT
2026-10-04 18:55:01 INFO Transaction TXN10013 started for account 2001
2026-10-04 18:55:02 INFO Transaction TXN10013 completed successfully

This demonstrates that a temporary failure can sometimes recover after retry.

However, retry behavior must follow the application's business rules and must not be performed blindly for financial transactions.

---

## 5. Incident vs Problem

An incident is an event that causes or may cause service disruption and requires investigation or restoration.

A problem is the underlying cause or potential cause of one or more incidents.

For example:

Incident:
TXN10004 failed with DB_TIMEOUT

Problem:
Possible underlying database connectivity or
application connection-management issue

The incident can be identified before the underlying problem is fully understood.

---

## 6. Incident Investigation Checklist

When investigating a similar issue:

[ ] Confirm the reported issue
[ ] Identify affected transaction/user
[ ] Check application logs
[ ] Check error logs
[ ] Check access logs
[ ] Check database records
[ ] Check application_errors
[ ] Check application process
[ ] Check network connectivity
[ ] Check database connectivity
[ ] Check recent changes
[ ] Determine impact
[ ] Apply approved workaround
[ ] Verify recovery
[ ] Document findings
[ ] Escalate if required
[ ] Continue RCA if root cause is not confirmed

---

## 7. Interview Explanation

If asked to explain the DB_TIMEOUT incident:

I first checked the application logs to identify the error and affected transaction. I found that TXN10004 failed with a DB_TIMEOUT error. Then I checked the transaction record in MySQL and correlated it with the account, customer, and application error records. The evidence showed that the application encountered a database connection timeout while processing the transaction. I would then verify database connectivity and investigate connections, resources, network connectivity, and query performance before determining the underlying root cause. I would not assume that the database server was down without evidence.

---

## 8. Key Lessons

The incidents demonstrate the following application support practices:

* Logs are important evidence during troubleshooting.
* Database records should be correlated with application logs.
* Error codes help narrow the investigation area.
* Repeated errors may indicate a larger problem.
* A successful retry does not automatically identify the root cause.
* Application availability and database availability must be checked separately.
* Root cause should be based on evidence.
* Incident documentation helps future troubleshooting.
* Support engineers should clearly separate confirmed facts from assumptions.

---

## 9. Project Limitation

This project is a simulated application support environment.

The incidents, transactions, logs, and errors are created for learning and portfolio purposes.

They should not be represented as real production banking incidents or real customer data.


---
---
