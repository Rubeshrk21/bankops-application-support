#!/bin/bash

LOG_FILE="$HOME/bankops-support/logs/application.log"

ERROR_COUNT=$(grep -c "ERROR" "$LOG_FILE")
WARN_COUNT=$(grep -c "WARN" "$LOG_FILE")
DB_TIMEOUT_COUNT=$(grep -c "DB_TIMEOUT" "$LOG_FILE")

echo "======================================"
echo "       BANKOPS LOG MONITOR"
echo "======================================"

echo "Log file: $LOG_FILE"
echo ""

echo "Total log entries:"
wc -l < "$LOG_FILE"

echo ""

echo "INFO entries:"
grep -c "INFO" "$LOG_FILE"

echo ""

echo "WARN entries:"
echo "$WARN_COUNT"

echo ""

echo "ERROR entries:"
echo "$ERROR_COUNT"

echo ""

echo "Top application errors:"
awk '$3 == "ERROR" {print $8}' "$LOG_FILE" | sort | uniq -c | sort -nr

echo ""

if [ "$ERROR_COUNT" -gt 0 ]
then
	    echo "WARNING: Application errors detected."
fi

if [ "$DB_TIMEOUT_COUNT" -gt 0 ]
then
	    echo "WARNING: DB_TIMEOUT errors detected: $DB_TIMEOUT_COUNT"
fi

if [ "$DB_TIMEOUT_COUNT" -gt 2 ]
then
	    echo "ALERT: Repeated DB_TIMEOUT errors require investigation."
fi

echo ""

echo "Latest 5 log entries:"
tail -n 5 "$LOG_FILE"

echo "======================================"
