# Day 21 – Docker Storage
## Volumes vs Bind Mounts vs tmpfs

### Objective
Understand how Docker handles persistent and temporary data using
volumes, bind mounts, and tmpfs through theory and hands-on labs.

---

## 1. Docker Volumes

### Description
Docker volumes are storage locations managed by Docker and stored
outside the container’s writable layer.

### Key Points
- Managed by Docker
- Persistent across container restarts and deletions
- Not directly accessible from the host
- Portable and production-ready
- Can be shared between containers

### Day 21 Challenge – Shared Volume

Two containers were run using the same Docker volume.
Container A wrote data to the volume.
Container B successfully read the same data, proving volume persistence
and multi-container sharing.
