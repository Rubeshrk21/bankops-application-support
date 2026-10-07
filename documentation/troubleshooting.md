# BankOps Troubleshooting Guide

## 1. Purpose

This document describes the troubleshooting approach used in the BankOps Application Support project.

The objective is to investigate issues systematically, collect evidence, isolate the affected layer, restore service, identify the underlying cause, and document the resolution.

---

## 2. General Application Support Troubleshooting Flow

Issue Reported
      |
      v
Identify the Problem
      |
      v
Collect Evidence
      |
      v
Check Application Logs
      |
      v
Check System / Process Health
      |
      v
Check Network Connectivity
      |
      v
Check Database Connectivity
      |
      v
Check Authentication / Authorization
      |
      v
Check Application Dependencies
      |
      v
Isolate the Fault
      |
      v
Apply Workaround or Fix
      |
      v
Verify
      |
      v
Document

The troubleshooting process should be evidence-based rather than assumption-based.

---

## 3. Application Process Troubleshooting

A running application process does not always mean that the application is healthy or available.

### Example

The BankOps simulator can be started using:

nohup python3 -u application.py > ~/bankops-support/logs/runtime.log 2>&1 &

The process can be checked using:

ps -ef | grep '[a]pplication.py'

A process may be running while the application is still unavailable because:

* The expected port is not listening
* The application is returning errors
* A database dependency is unavailable
* A downstream service is unavailable
* The application is stuck or unhealthy

Therefore:

RUNNING does not always mean AVAILABLE.

---

## 4. Log Investigation

Application logs are one of the first sources of evidence during troubleshooting.

Useful commands include:

tail -n 5 ~/bankops-support/logs/application.log

tail -f ~/bankops-support/logs/application.log

grep "ERROR" ~/bankops-support/logs/application.log

grep "DB_TIMEOUT" ~/bankops-support/logs/application.log

grep -c "ERROR" ~/bankops-support/logs/application.log

grep -c "DB_TIMEOUT" ~/bankops-support/logs/application.log

These commands help identify:

* What happened
* When it happened
* How frequently it happened
* Which error occurred
* Whether the error is repeated

---

## 5. DB_TIMEOUT Investigation

A `DB_TIMEOUT` indicates that the application experienced a timeout while communicating with the database.

It should not automatically be interpreted as proof that the database server is down.

### Investigation sequence

Application Log
      |
      v
Identify DB_TIMEOUT
      |
      v
Identify Timestamp / Transaction
      |
      v
Test Database Connectivity
      |
      v
Check Database Host
      |
      v
Check Database Port
      |
      v
Check Authentication
      |
      v
Check Authorization
      |
      v
Check Database Availability
      |
      v
Check Connections / Resources
      |
      v
Check Query Performance
      |
      v
Investigate Network / Firewall

---

## 6. Database Connectivity Troubleshooting

The project demonstrated that MySQL can be available on one environment while not being available through the same `localhost` address from another environment.

For example:

Windows
    |
    | MySQL
    | Port 3306
    v
Windows localhost

WSL has its own network environment:

WSL
    |
    | localhost
    v
WSL localhost

Therefore, Windows `localhost` and WSL `localhost` are not necessarily the same endpoint.

The Windows host IP can be used from WSL when the database is listening on that interface and access is permitted.

---

## 7. Port Connectivity Testing

`ping` and TCP port testing answer different questions.

### Ping

ping -c 4 google.com

`ping` tests ICMP reachability.

It does not test whether a specific application port is available.

### TCP Port Test

For a MySQL service:

nc -zv <database-host> 3306

For HTTPS:

nc -zv <application-host> 443

A successful TCP connection indicates that the host and requested port are reachable at the network level.

---

## 8. Authentication and Authorization

These are different concepts.

### Authentication

Authentication answers:

Who are you?

Examples:

* Username
* Password
* Authentication token

### Authorization

Authorization answers:

What are you allowed to access?

For MySQL, useful commands include:

SELECT User, Host
FROM mysql.user
WHERE User = 'bankops_app';

And:

SHOW GRANTS FOR 'bankops_app'@'localhost';

A successful network connection does not guarantee successful database authentication or authorization.

---

## 9. DNS Troubleshooting

When an application reports:

Unknown host: db-prod.company.com

DNS should be investigated first.

Useful commands include:

getent hosts db-prod.company.com

or:

nslookup db-prod.company.com

If the hostname resolves to an IP address, the next step is to test connectivity to the expected service port.

Example:

nc -zv 10.20.30.15 3306

The troubleshooting sequence is:

Hostname
   |
   v
DNS Resolution
   |
   v
IP Address
   |
   v
TCP Port
   |
   v
Authentication
   |
   v
Authorization

---

## 10. HTTP / HTTPS Troubleshooting

HTTP status codes provide useful information during Application Support troubleshooting.

Common examples:

| Status Code | Meaning                          |
| ----------- | -------------------------------- |
| 200         | Successful request               |
| 301         | Permanent redirect               |
| 302         | Temporary redirect               |
| 400         | Bad request                      |
| 401         | Authentication required / failed |
| 403         | Forbidden                        |
| 404         | Resource not found               |
| 500         | Internal server error            |
| 502         | Bad gateway                      |
| 503         | Service unavailable              |
| 504         | Gateway timeout                  |

A `404` does not necessarily mean the server is down.

A `500` indicates that the request reached the server but the server encountered an application-side error.

---

## 11. Testing an Application Endpoint

The following command can be used to inspect HTTP response headers:

curl -I https://example.com

For a request that fails with HTTP 500, the application is reachable.

The investigation should therefore move toward:

* Application logs
* Application process
* Backend dependencies
* Database
* External services
* Application configuration

rather than immediately assuming that the server is unreachable.

---

## 12. HTTP 401 and 403

### HTTP 401

A `401 Unauthorized` response generally indicates an authentication problem.

Possible areas to investigate:

* Username
* Password
* Access token
* Token expiration
* Authentication configuration

### HTTP 403

A `403 Forbidden` response generally indicates that the request was understood but access is not permitted.

Possible areas to investigate:

* User permissions
* Roles
* Access control rules
* Application authorization configuration

---

## 13. Connection Refused vs Timeout

These errors should not be treated as identical.

### Connection Refused

Example:

```text
Connection refused
```

Possible causes include:

* Service is not running
* Nothing is listening on the requested port
* Service is listening on a different port
* Firewall or network configuration is rejecting the connection

Useful test:

nc -zv <host> <port>

### Connection Timeout

Example:

Connection timed out

Possible areas to investigate include:

* Network connectivity
* Firewall rules
* Routing
* Service responsiveness
* Database responsiveness
* Connection limits
* Long-running queries
* Infrastructure performance

---

## 14. Slow Application Response

A request can return HTTP 200 and still have a performance problem.

For example:

Normal response time: 1 second
Observed response time: 12.8 seconds
HTTP status: 200

The application is technically available, but it is slow.

Possible areas to investigate:

* Network latency
* Load balancer
* Application server resources
* Database performance
* Long-running queries
* External API response time
* Connection pool usage

A useful diagnostic command is:

curl -w "\nTime: %{time_total}s\n" \
-o /dev/null -s https://example.com

---

## 15. Health Check vs Monitoring

### Health Check

A health check is an active test performed to determine whether a service is responding.

Example:

curl -I https://example.com

### Monitoring

Monitoring continuously observes a system and can generate alerts when abnormal conditions are detected.

The BankOps `log_monitor.sh` script is a basic example of support monitoring.

It checks application logs and raises an alert when repeated `DB_TIMEOUT` errors are detected.

---

## 16. Incident vs Problem

### Incident

An incident is an unplanned interruption or degradation of a service.

Example:

Customers are unable to complete transactions.

### Problem

A problem is the underlying cause or potential cause of one or more incidents.

Example:

Repeated database connection timeouts are affecting multiple transactions.

The incident describes the service impact.

The problem investigation focuses on why the incidents are occurring.

---

## 17. Workaround vs Permanent Fix

A workaround is a temporary method used to restore service.

Example:

Restarting an application process may temporarily restore service.

However, restarting the application does not automatically identify or fix the underlying cause.

A permanent fix should address the actual root cause.

Example:

If the root cause is an incorrect database connection configuration, correcting the configuration is more appropriate than repeatedly restarting the application.

---

## 18. Root Cause Analysis

Root Cause Analysis should be based on evidence.

For a database timeout:

Symptom
   |
   v
Transaction Failed
   |
   v
DB_TIMEOUT
   |
   v
Database Connection Timeout
   |
   v
Investigate Why Timeout Occurred
   |
   +-- Network?
   +-- Firewall?
   +-- Connection Limit?
   +-- Database Resources?
   +-- Query Performance?
   +-- Configuration?

The first error observed is not necessarily the final root cause.

---

## 19. Example Support Investigation

### Reported Issue

A customer reports that a transaction failed.

### Step 1 — Identify

Transaction ID:

TXN10004

### Step 2 — Check Application Logs

ERROR Transaction TXN10004 failed with DB_TIMEOUT

### Step 3 — Check Database

SELECT *
FROM transactions
WHERE transaction_id = 'TXN10004';

### Step 4 — Identify Customer

Join:

Transaction
    |
    v
Account
    |
    v
Customer

### Step 5 — Check Error Details

DB_TIMEOUT
Database connection timeout while processing transaction

### Step 6 — Investigate

Check:

* Database connectivity
* Host and port
* Authentication
* Authorization
* Database availability
* Connections
* Resources
* Query performance
* Network and firewall

### Step 7 — Verify

After the issue is resolved, verify the transaction/application behavior and confirm that similar errors are no longer occurring.

### Step 8 — Document

Record:

* Incident details
* Evidence
* Investigation
* Workaround
* Root cause
* Resolution
* Verification

---

## 20. Troubleshooting Principle

The most important principle followed throughout this project is:

Troubleshoot from evidence, not assumptions.

An Application Support Engineer should progressively narrow the problem from:

Application
    |
    v
Process
    |
    v
Logs
    |
    v
Network
    |
    v
Port
    |
    v
Authentication
    |
    v
Authorization
    |
    v
Database
    |
    v
Dependencies

This approach helps isolate the fault efficiently and reduces unnecessary changes to the environment.

---
---
