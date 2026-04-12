#!/bin/bash

LOG_FILE="../logs/app.log"
mkdir -p ../logs
> $LOG_FILE

echo "Generating logs..."

for i in {1..150}; do
    case $((RANDOM % 6)) in
        0) echo "$(date) INFO: System running normally" >> $LOG_FILE ;;
        1) echo "$(date) WARN: Memory usage high" >> $LOG_FILE ;;
        2) echo "$(date) ERROR: Database connection failed" >> $LOG_FILE ;;
        3) echo "$(date) CRITICAL: Service crashed" >> $LOG_FILE ;;
        4) echo "$(date) FATAL: Kernel panic detected" >> $LOG_FILE ;;
        5) echo "$(date) ERROR: Timeout error occurred" >> $LOG_FILE ;;
    esac
done

echo "Logs generated at $LOG_FILE"
