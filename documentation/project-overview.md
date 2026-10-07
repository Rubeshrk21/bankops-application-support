# BankOps Application Support Project

## 1. Project Overview

BankOps is a simulated banking application support environment created as a personal learning project to develop practical IT Application Support skills.

The project combines Linux administration, MySQL database operations, Bash scripting, application log monitoring, networking fundamentals, incident investigation, and troubleshooting.

The environment simulates common Application Support activities such as:

- Investigating failed transactions
- Analyzing application and error logs
- Troubleshooting database connectivity
- Querying transaction and customer information using SQL
- Monitoring application errors
- Creating log backups
- Investigating repeated application failures
- Documenting incidents and troubleshooting steps

This is a simulated training environment and does not represent production banking infrastructure or real customer data.

---

## 2. Project Architecture

User / Support Request
        |
        v
BankOps Application
        |
        +--------------------+
        |                    |
        v                    v
   Application Logs      MySQL Database
        |                    |
        |                    +-- customers
        |                    +-- accounts
        |                    +-- transactions
        |                    +-- support_tickets
        |                    +-- application_errors
        |
        v
Log Monitoring
        |
        v
Incident Investigation
        |
        v
Troubleshooting / Resolution

---

## 3. Technologies Used

- Linux / Ubuntu on WSL
- MySQL
- MySQL Workbench
- Bash scripting
- Python
- SQL
- Git
- GitHub

---

## 4. Linux and Application Support Activities

The project was used to practice common Linux support operations including:
- Navigating directories
- Creating and managing files
- Checking running processes
- Monitoring application processes
- Monitoring logs
- Searching logs using grep
- Filtering log information using awk
- Sorting and counting error occurrences
- Monitoring disk and memory usage
- Creating compressed log backups
- Scheduling backup jobs using cron
- Managing file permissions
- Testing network and port connectivity

---

## 5. Database Support Activities

# customers
Stores customer information.

# accounts
Stores customer account information and maintains a relationship with the customers table.

# transactions
Stores transaction information including transaction status and error codes.

# support_tickets
Stores support cases related to customers and transactions.

# application_errors
Stores application-level errors associated with transactions.

The database contains simulated sample data for troubleshooting and SQL practice.

---

## 6. SQL Support Activities

SQL was used to investigate application and customer issues.

Examples include:
- Finding failed transactions
- Finding the highest-value transaction
- Counting transactions
- Grouping transactions by status
- Identifying repeated application errors
- Joining customer, account, and transaction information
- Investigating a specific transaction
- Finding transactions above the average amount
- Investigating support tickets
- Identifying high-severity application errors

---

## 7. Log Monitoring

A Bash script named log_monitor.sh was created to monitor the application log.

The script checks:
- Total log entries
- INFO entries
- WARN entries
- ERROR entries
- DB_TIMEOUT occurrences
- Top application errors
- Latest log entries

The script also generates warnings when application errors are detected and raises an alert when repeated DB_TIMEOUT errors require investigation.

---

## 8.Log Backup

A Bash script named backup_logs.sh was created to create compressed backups of the application log.

The backup process uses tar and creates timestamped .tar.gz files.

A cron job was configured to execute the backup script periodically.

This simulates a basic operational task used to preserve application logs for troubleshooting and audit purposes.

---

## 9. Incident Investigation Example

One simulated incident involved transaction TXN10004.

The transaction was recorded as:
- Transaction ID: TXN10004
- Account ID: 2004
- Transaction type: TRANSFER
- Amount: 4500.00
- Status: FAILED
- Error code: DB_TIMEOUT

The application log showed that the transaction failed with a database timeout.

The error log provided additional information indicating a database connection timeout while processing the transaction.

The incident was then correlated with the MySQL transaction and application error records.

The investigation demonstrated how an Application Support Engineer can correlate information across:

Application Logs
       |
       v
Error Details
       |
       v
Database Records
       |
       v
Customer / Account Information
       |
       v
Root Cause Investigation

The evidence confirms a database connection timeout occurred. The deeper reason for the timeout would require further investigation of database connectivity, connections, resources, query performance, and related infrastructure.

---

## 10. Repeated Error Investigation

The application logs also contain a simulated pattern of repeated DB_TIMEOUT errors.

The log monitoring script identifies the repeated errors and raises an alert.

The investigation approach is:
1. Review application and error logs.
2. Identify affected transactions and timestamps.
3. Correlate the incidents with database records where available.
4. Verify database connectivity.
5. Verify the database host and port.
6. Check authentication and authorization.
7. Check database availability and connections.
8. Check resource usage and query performance.
9. Investigate network or firewall issues when required.
10. Determine the underlying root cause.
11. Apply an appropriate workaround or fix.
12. Verify the service and document the incident.

---

## 11. Troubleshooting Methodology

The project follows a structured Application Support troubleshooting approach:

IDENTIFY
   |
   v
COLLECT EVIDENCE
   |
   v
INVESTIGATE
   |
   v
ISOLATE THE FAULT
   |
   v
RESTORE SERVICE
   |
   v
FIND ROOT CAUSE
   |
   v
PERMANENT FIX
   |
   v
VERIFY
   |
   v
DOCUMENT

The objective is to use evidence before making assumptions about the root cause.

---

## 12.Learning Outcomes

Through this project, practical exposure was gained in:

- Linux command-line operations
- MySQL and SQL troubleshooting
- Application log analysis
- Bash scripting
- Process monitoring
- Basic network troubleshooting
- DNS and TCP port testing
- HTTP status-code troubleshooting
- Database connectivity investigation
- Incident and problem concepts
- Root Cause Analysis
- Log backup and scheduled jobs
- Technical documentation
- Application Support troubleshooting methodology

---

## 13. Project Limitation

BankOps is a simulated learning environment.

The Python application is intentionally lightweight and is used to simulate a running application process and operational logs. It is not a production banking application and does not implement real banking transaction processing, authentication, payment processing, or customer-facing APIs.

The purpose of the project is to demonstrate practical Application Support troubleshooting skills rather than production application development.

---
---
