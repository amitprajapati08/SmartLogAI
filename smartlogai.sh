#!/bin/bash

source config/smartlogai.conf

mkdir -p "$ARCHIVE_DIR" "$REPORT_DIR"

LOG_FILE="$LOG_DIR/app.log"

echo "🔍 Running SmartLogAI..."

# Severity Count
fatal=$(grep -ci "FATAL" "$LOG_FILE")
critical=$(grep -ci "CRITICAL" "$LOG_FILE")
error=$(grep -ci "ERROR" "$LOG_FILE")
warn=$(grep -ci "WARN" "$LOG_FILE")

# AI Score
score=$((fatal*SEVERITY_FATAL + critical*SEVERITY_CRITICAL + error*SEVERITY_ERROR + warn*SEVERITY_WARN))

echo "AI Severity Score: $score"

# Anomaly Detection
recent_errors=$(tail -50 "$LOG_FILE" | grep -ci "ERROR")

if [ "$recent_errors" -gt "$ANOMALY_THRESHOLD" ]; then
    anomaly_msg="⚠️ Error Spike Detected"
else
    anomaly_msg="Normal"
fi

# Repeated pattern detection
repeat=$(tail -50 "$LOG_FILE" | sort | uniq -c | sort -nr | head -1 | awk '{print $1}')

if [ "$repeat" -gt "$REPEAT_THRESHOLD" ]; then
    anomaly_msg="$anomaly_msg + Repeated Pattern"
fi

echo "Anomaly Status: $anomaly_msg"

# Compression
size=$(stat -c%s "$LOG_FILE")
timestamp=$(date +%s)

if [ "$size" -gt 100000 ]; then
    archive_file="$ARCHIVE_DIR/log_$timestamp.xz"
    xz -c "$LOG_FILE" > "$archive_file"
    method="xz"
elif [ "$size" -gt 50000 ]; then
    archive_file="$ARCHIVE_DIR/log_$timestamp.bz2"
    bzip2 -c "$LOG_FILE" > "$archive_file"
    method="bzip2"
else
    archive_file="$ARCHIVE_DIR/log_$timestamp.gz"
    gzip -c "$LOG_FILE" > "$archive_file"
    method="gzip"
fi

echo "Archived using $method → $archive_file"

# Rotation
count=$(ls "$ARCHIVE_DIR" | wc -l)

if [ "$count" -gt "$MAX_ARCHIVES" ]; then
    ls -t "$ARCHIVE_DIR" | tail -n +$((MAX_ARCHIVES+1)) | while read file; do
        rm "$ARCHIVE_DIR/$file"
    done
fi

# Dashboard
REPORT="$REPORT_DIR/dashboard_$timestamp.html"

cat <<EOF > "$REPORT"
<html>
<head>
<title>SmartLogAI Dashboard</title>
<style>
body { background:#0f172a; color:#e2e8f0; font-family:Arial; }
.card { background:#1e293b; padding:20px; margin:10px; border-radius:10px; }
h1 { color:#38bdf8; }
</style>
</head>
<body>

<h1>🚀 SmartLogAI Dashboard</h1>

<div class="card">
<h2>AI Score: $score</h2>
<p>Anomaly: $anomaly_msg</p>
</div>

<div class="card">
<p>FATAL: $fatal</p>
<p>CRITICAL: $critical</p>
<p>ERROR: $error</p>
<p>WARN: $warn</p>
</div>

</body>
</html>
EOF

echo "📊 Report generated: $REPORT"
