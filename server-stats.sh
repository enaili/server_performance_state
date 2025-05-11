#!/bin/bash

echo "📊 Server Performance Stats - $(hostname)"
echo "-----------------------------------------"

# 1. Total CPU Usage
echo ""
echo "🧠 CPU Usage:"
top -bn1 | grep "Cpu(s)" | awk '{print "Used: " $2 + $4 "% | Idle: " $8 "%"}'

# 2. Memory Usage
echo ""
echo "🧠 Memory Usage:"
free -m | awk 'NR==2{printf "Used: %s MB / %s MB (%.2f%%)\n", $3,$2,$3*100/$2 }'

# 3. Disk Usage
echo ""
echo "💽 Disk Usage:"
df -h --total | grep total | awk '{print "Used: " $3 " / " $2 " (" $5 " used)"}'

# 4. Top 5 processes by CPU usage
echo ""
echo "🔥 Top 5 Processes by CPU:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

# 5. Top 5 processes by Memory usage
echo ""
echo "💾 Top 5 Processes by Memory:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6

# 6. Stretch goals
echo ""
echo "🧩 Additional System Info:"
echo "OS Version: $(lsb_release -d | cut -f2)"
echo "Uptime: $(uptime -p)"
echo "Load Average: $(uptime | awk -F'load average:' '{print $2}')"
echo "Logged in users: $(who | wc -l)"
echo "Failed login attempts:"
lastb | head -n 5 2>/dev/null || echo "Requires 'lastb' (install syslog/wtmp support)"

echo "-----------------------------------------"

