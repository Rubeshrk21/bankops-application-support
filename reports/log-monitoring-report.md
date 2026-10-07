# BankOps Log Monitoring Report

## 1. Purpose

This report documents the log monitoring activities performed in the BankOps Application Support project.

The objective is to demonstrate how an application support engineer can monitor application logs, identify errors, detect repeated failures, and investigate incidents.

---

## 2. Log Files Monitored

The project contains several application-related log files.

| Log File | Purpose |
|---|---|
| application.log | Application transaction activity and errors |
| error.log | Detailed application errors |
| access.log | Simulated HTTP/API request activity |
| runtime.log | Application runtime output |
| cron_backup.log | Backup operation output |

The primary log used by the monitoring script is:

~/bankops-support/logs/application.log

---

## 3. Monitoring Script

The monitoring script is:

scripts/log_monitor.sh

It performs the following checks:

* Counts total log entries
* Counts INFO entries
* Counts WARN entries
* Counts ERROR entries
* Counts DB_TIMEOUT errors
* Displays the most common application errors
* Displays the latest five log entries
* Generates a warning when errors are detected
* Generates a warning when DB_TIMEOUT errors are detected
* Generates an alert when repeated DB_TIMEOUT errors exceed the threshold

---

## 4. Monitoring Commands Used

The script uses standard Linux commands and utilities.

### `grep`

Used to search for specific text patterns.

Example:

grep -c "ERROR" application.log

This counts the number of log lines containing `ERROR`.

---

### `wc`

Used to count lines.

Example:

wc -l application.log

This provides the total number of log entries.

---

### `awk`

Used to extract specific fields from structured log lines.

Example:

awk '$3 == "ERROR" {print $8}' application.log

This extracts the error code from matching error entries based on the structure of the log.

---

### `sort`

Used to sort the extracted error values.

sort

---

### `uniq`

Used to count repeated error values.

uniq -c

---

### `tail`

Used to view the most recent log entries.

tail -n 5 application.log

This is useful when investigating the latest application activity.

---

## 5. Monitoring Results

The monitoring script reported:

Total log entries: 35

INFO entries: 26

WARN entries: 1

ERROR entries: 8

The error distribution was:

DB_TIMEOUT       7
ACCOUNT_BLOCKED  1

The monitoring script therefore identified repeated `DB_TIMEOUT` errors.

---

## 6. Alert Logic

The monitoring script contains threshold-based logic.

### Error detection

If at least one error exists:

if [ "$ERROR_COUNT" -gt 0 ]
then
    echo "WARNING: Application errors detected."
fi

The script reports that application errors require investigation.

### DB_TIMEOUT detection

If a database timeout exists:

if [ "$DB_TIMEOUT_COUNT" -gt 0 ]
then
    echo "WARNING: DB_TIMEOUT errors detected: $DB_TIMEOUT_COUNT"
fi

### Repeated DB_TIMEOUT detection

If more than two DB_TIMEOUT errors exist:

if [ "$DB_TIMEOUT_COUNT" -gt 2 ]
then
    echo "ALERT: Repeated DB_TIMEOUT errors require investigation."
fi

The threshold is intentionally simple because this is a learning project.

In a production environment, alert thresholds would normally be based on application requirements, historical behavior, severity, and operational policies.

---

## 7. Error Analysis

The monitoring results show:

| Error           | Count | Interpretation                                       |
| --------------- | ----: | ---------------------------------------------------- |
| DB_TIMEOUT      |     7 | Repeated database connection timeout errors          |
| ACCOUNT_BLOCKED |     1 | Transaction rejected because the account was blocked |
| Total           |     8 | Total application errors                             |

The repeated `DB_TIMEOUT` errors are more significant from an application support perspective because they occurred multiple times.

---

## 8. Latest Log Activity

The latest application log entries included transactions such as:

2026-10-04 19:10:01 INFO Transaction TXN10015 started for account 2003
2026-10-04 19:10:03 ERROR Transaction TXN10015 failed with DB_TIMEOUT
2026-10-04 19:11:01 INFO Transaction TXN10016 started for account 2006
2026-10-04 19:11:03 ERROR Transaction TXN10016 failed with DB_TIMEOUT
2026-10-04 19:12:01 INFO Transaction TXN10017 started for account 2007
2026-10-04 19:12:03 ERROR Transaction TXN10017 failed with DB_TIMEOUT

This pattern indicates that the timeout error was not isolated to a single transaction in the simulated environment.

---

## 9. Support Investigation Trigger

The monitoring result does not itself prove the root cause.

Instead, it acts as an investigation trigger.

The investigation should proceed approximately as follows:

Repeated DB_TIMEOUT
        |
        v
Identify affected transactions
        |
        v
Check application logs
        |
        v
Check database records
        |
        v
Check database connectivity
        |
        v
Check network connectivity
        |
        v
Check connection availability
        |
        v
Check database resources
        |
        v
Check query performance
        |
        v
Review database/application logs
        |
        v
Determine root cause

---

## 10. Important Troubleshooting Principle

A monitoring alert tells the support engineer that something requires attention.

It does not automatically tell the engineer why the problem occurred.

For example:

DB_TIMEOUT

does not automatically mean:

Database server is down.

Other possible causes could include:

* Network connectivity problems
* Connection pool exhaustion
* Database resource pressure
* Slow queries
* Application connection handling
* Temporary database unavailability

These possibilities must be investigated using evidence.

---

## 11. Relationship Between Monitoring and Incident Management

The monitoring script can be considered an early detection mechanism.

The relationship is:

Log
 |
 v
Monitoring
 |
 v
Alert
 |
 v
Incident Investigation
 |
 v
Evidence Collection
 |
 v
Service Restoration
 |
 v
Root Cause Analysis
 |
 v
Documentation

This demonstrates the difference between monitoring and troubleshooting.

Monitoring identifies unusual behavior.

Troubleshooting determines what is happening and why.

---

## 12. Verification

After modifying or adding simulated log entries, the monitoring script was executed again to verify that it correctly detected:

* Increased ERROR count
* Increased DB_TIMEOUT count
* Repeated DB_TIMEOUT condition
* Latest log entries

This confirms that the script responds to changes in the application log.

---

## 13. Limitations

This monitoring solution is intentionally simple.

It does not currently provide:

* Email notifications
* SMS notifications
* Dashboard visualization
* Centralized log collection
* Automatic incident ticket creation
* Log rotation
* Advanced anomaly detection
* Production monitoring integrations

The script is designed to demonstrate fundamental Linux-based application support and log-monitoring concepts.

---

## 14. Interview Explanation

If asked to explain the log monitoring work:

I created a Bash log monitoring script that checks the application log for INFO, WARN, and ERROR entries. It also counts DB_TIMEOUT errors and identifies repeated timeout conditions. I used Linux commands such as grep, awk, sort, uniq, wc, and tail. When repeated DB_TIMEOUT errors crossed the defined threshold, the script generated an alert. I then used those alerts as a starting point for incident investigation by correlating the logs with MySQL transaction and error records.

---

## 15. Key Learning Outcomes

Through this activity, I practiced:

* Linux log analysis
* Bash scripting
* Error pattern detection
* Log filtering
* Incident detection
* Basic alerting
* Application troubleshooting
* Database and log correlation
* Evidence-based root cause analysis
* Technical incident documentation

---
---
