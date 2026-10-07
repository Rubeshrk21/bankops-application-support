#!/bin/bash

LOG_FILE="$HOME/bankops-support/logs/application.log"
BACKUP_DIR="$HOME/bankops-support/backups"

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

tar -czf "$BACKUP_DIR/application_log_$TIMESTAMP.tar.gz" "$LOG_FILE"

echo "Log backup completed: $TIMESTAMP"
