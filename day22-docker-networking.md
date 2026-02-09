# Day 22 – Docker Networking
## Bridge, Ports, and Container Communication

### Objective
Understand how Docker networking works, how containers communicate,
how ports are exposed to the host, and how networking can fail when
host firewall rules are misconfigured.

---

## 1. Why Docker Networking Matters

Containers are isolated by default.
Without proper networking:
- Containers cannot talk to each other
- `localhost` only refers to the container itself
- Services are unreachable from the host

---

## 2. Docker Network Types

| Network Type | Description | Use Case |
|-------------|-------------|----------|
| bridge | Default Docker network | Basic container networking |
| user-defined bridge | Custom bridge with DNS | Multi-container apps |
| host | Uses host network directly | High performance, low isolation |
| none | No networking | Full isolation |

---

## 3. Default Bridge Network Behavior

- Containers receive IP addresses automatically
- Container names are NOT resolvable via DNS
- Communication requires IP addresses
- Legacy behavior

Example:
```bash
ping web2
# fails: name resolution

### Default Bridge Network Limitation

When containers run on the default bridge network,
container names cannot be resolved via DNS.

Communication is possible using IP addresses only.

User-defined bridge networks provide automatic DNS
resolution by container name.

4. Port Publishing (Host ↔ Container)

Run nginx and expose it to the host:

docker run -d --name nginx1 -p 8080:80 nginx


8080 = host port

80 = container port

Access via: http://localhost:8080

This confirms host-to-container networking works.

5. User-Defined Bridge Network (Expected Behavior)

Normally, a user-defined bridge network provides:

Automatic DNS resolution

Container-name-based communication

Better isolation than default bridge

Example (expected):

docker network create day22_net
docker run -dit --name app1 --network day22_net alpine sh
docker run -dit --name app2 --network day22_net alpine sh
ping app2

6. Networking Failure Encountered (Important)

During this lab, container-to-container networking failed due to
iptables / nftables backend conflicts on the host system.

Observed errors:

Temporary failure in name resolution

Destination Host Unreachable

Docker isolation chains missing

This caused:

Broken bridge routing

Non-functional Docker DNS (127.0.0.11)

7. Key Troubleshooting Lessons

Docker networking depends on host firewall (iptables)

Containers can run while networking is broken

Restarting Docker does not always fix iptables state

Port publishing may still work even when container DNS fails

Orchestration tools handle networking more reliably

8. Best Practices

Use Docker Compose instead of manual networks

Avoid relying on default bridge for multi-container apps

Publish only required ports

Understand that networking issues are often host-level problems

Key Takeaways

localhost is container-specific

Default bridge has no DNS by name

User-defined networks enable DNS (when host is healthy)

Docker networking is tightly coupled to iptables

Real-world Docker includes debugging, not just success paths

Day 22 Status

Completed Docker networking deep dive with real-world
troubleshooting and host-level failure analysis.

### Networking Failure Debugging

Encountered `Destination Host Unreachable` when pinging
container IPs on the default bridge network.

Cause:
Broken Docker iptables isolation chains due to
iptables / nftables backend mismatch.

Resolution:
Reset Docker networking state and recreate containers.

Docker container names must be unique.
Stopped containers still reserve their names
until removed.

### Docker Networking Troubleshooting

While creating user-defined bridge networks,
container DNS resolution failed due to
iptables / nftables backend issues on the host.

Observed behaviors:
- Port publishing (-p) works correctly
- Containers start successfully
- Container-to-container DNS resolution fails
- Bridge routing returns "Destination Host Unreachable"

Conclusion:
Docker networking relies on correct host
iptables configuration. When broken,
Compose or orchestration tools are preferred.
