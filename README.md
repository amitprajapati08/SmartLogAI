# SmartLogAI: AI-Based Log Analysis and Archiving System

## Overview

SmartLogAI is a lightweight, AI-inspired log monitoring and archiving system developed using Unix shell scripting. It enhances traditional log management by introducing automated analysis, anomaly detection, and visualization.

## Problem Statement

Traditional logging systems focus on storing logs rather than analyzing them. This leads to delayed detection of system failures and requires manual monitoring.

## Solution

SmartLogAI automates the entire log lifecycle:

- Reads and analyzes system logs
- Assigns severity scores based on weighted logic
- Detects anomalies such as error spikes and repeated patterns
- Compresses and archives logs efficiently
- Generates a dashboard for system insights

## Features

- Severity-based log analysis
- AI-inspired scoring mechanism
- Anomaly detection (error spike and repetition)
- Smart compression (gzip, bzip2, xz)
- Archive rotation
- HTML dashboard reporting
- Configurable system via configuration file

## Project Structure
SmartLogAI/
│── logs/
│── archive/
│── reports/
│── config/
│ └── smartlogai.conf
│── scripts/
│ └── generate_logs.sh
│── smartlogai.sh
│── dashboard.png
│── README.md


## How It Works

1. Logs are generated with different severity levels
2. The system analyzes logs using pattern matching
3. Severity score is calculated using weighted values
4. Anomalies are detected based on thresholds and patterns
5. Logs are compressed and archived
6. A dashboard is generated for visualization

## Sample Output

- AI Severity Score: 1014
- Anomaly: Error spike and repeated pattern detected
- Archive created using compression
- Dashboard generated showing system status

## Technologies Used

- Bash (Shell Scripting)
- Linux (Kali Linux)
- grep, awk, sort, uniq
- gzip, bzip2, xz

## Unique Aspects

- Implements AI-inspired logic using shell scripting
- Combines analysis, detection, and archiving in one system
- Lightweight and does not require external dependencies
- Designed for real-world log monitoring scenarios

## Limitations

- Rule-based system (not predictive)
- Limited to predefined patterns
- No real-time alerting mechanism

## Future Scope

- Machine learning integration
- Real-time alert system (email/notifications)
- Cloud deployment
- Advanced visualization dashboard

## Conclusion

SmartLogAI demonstrates how intelligent log analysis can be achieved using simple and efficient Unix shell scripting techniques. It provides a scalable and lightweight solution for automated log monitoring.

## Author
Amit Prajapat
