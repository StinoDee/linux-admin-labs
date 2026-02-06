# Day 18 – cgroups & systemd Resource Control

## Topics
- cgroups v2 overview
- systemd as cgroup manager
- CPUQuota, MemoryMax, TasksMax
- Difference between ulimit and cgroups

## Commands Practiced
- systemctl show
- systemctl set-property
- systemctl edit
- systemctl daemon-reexec

## Key Takeaway
Modern Linux uses systemd + cgroups for safe, production-grade
resource control instead of shell-based ulimit.
