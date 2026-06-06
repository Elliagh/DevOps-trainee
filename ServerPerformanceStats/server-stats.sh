#!/bin/bash
# Description: Shows server statistic
# Author: Elliagh
# Version: 1.0

echo $'================\nServer statistic\n================'

#OS version
echo $'\nOS version'
cat /etc/os-release | grep -E 'PRETTY_NAME'| cut -d= -f2

#Uptime
echo $'\nUptime'
uptime -p

#Total CPU Usage
echo $'\nTotal CPU usage'
top -bn1 | grep "Cpu(s)" | awk '{print "Used: "$2+$4 ", Idle: "$8}'

#Total memory usage (Free vs Used including percentage)
echo $'\nMemory usage'
free | grep "Mem" | awk '{printf "Total: %.1fGi\nUsed: %.1fGi(%.2f%)\nFree: %.1fGi(%.2f%)\n", $2/2^20, $3/1024^2, $3/$2*100, $4/2^20, $4/$2*100}'

#Total disk usage (Free vs Used including percentage
echo $'\nHome disk usage'
df | grep -w "/" | awk '{printf "Total: %.1fGi\nUsed: %.1fGi(%.2f%)\nFree: %.1fGi(%.2f%)\n", $2/2^20, $3/2^20, $3/$2*100, $4/2^20, $4/$2*100}'

#Top 5 processes by CPU usage
echo $'\nTop 5 processes by CPU usage'
ps aux --sort -%cpu | awk 'NR<7 {print $2,$3,$11}'

#Top 5 processes by memory usage
echo $'\nTop 5 processes by memory usage'
ps aux --sort -%mem | awk 'NR<7 {print $2,$4,$11}'
