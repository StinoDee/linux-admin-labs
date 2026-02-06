# Day 19 – Linux Namespaces & Containers

## Topics Covered
- Linux namespaces overview
- PID, UTS, mount, network, user namespaces
- Process isolation vs resource control
- Relationship between namespaces and containers

## Commands Practiced
- lsns
- unshare -u
- unshare -p
- unshare -m
- unshare -n
- unshare -Ur
- unshare -p -m -u -n -f

## Key Takeaways
Linux namespaces isolate what a process can see (PID, hostname,
filesystem, network, users). Combined with cgroups for resource
limits, they form the foundation of containers used by Docker,
Podman, and Kubernetes.

- User namespaces may be restricted by distro security policies;
 container runtimes like Docker manage user mappings internally.

## One-Line Summary
Containers are not virtual machines; they are processes isolated
using Linux namespaces and controlled using cgroups.
