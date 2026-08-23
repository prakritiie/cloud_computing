# experiment 5 — Resilience Verification via Chaos Testing

## Aim

To inject controlled failures into a containerized service and evaluate its **self-healing, health monitoring, and resource isolation** capabilities.

## Important Terms

* **Resilience:** Ability of a system to maintain acceptable service levels when failures occur.
* **Chaos Testing:** Intentionally introducing controlled failures to observe how a system responds and recovers.
* **Restart Policy:** Docker configuration that automatically restarts a container after failure. Here, `restart: always` is used.
* **Healthcheck:** A periodic test that verifies whether the application is actually functioning, not just whether its process is running.
* **Unhealthy:** Container state indicating that its configured healthcheck is failing.
* **cgroups:** Linux Control Groups used to limit and isolate container resources such as CPU and memory.
* **CPU Limit:** Restricts how much CPU a container can consume. Here, the limit is `0.25`.
* **Fault Isolation:** Preventing a failing or resource-intensive container from negatively affecting other services.

## What We Did

1. Created an Nginx-based resilient service using Docker Compose.
2. Configured:

   * `restart: always`
   * CPU limit of `0.25`
   * Memory limit of `128M`
   * Healthcheck for the Nginx endpoint.
3. Started and monitored the container using `docker compose` and `docker stats`.
4. **Chaos Test 1 — Container Termination:** Killed the main process and observed Docker automatically restart the container.
5. **Chaos Test 2 — Functional Failure:** Deleted `index.html` while keeping Nginx running and observed the container transition from **healthy → unhealthy**.
6. Restored `index.html` and verified that the service became healthy again.
7. **Chaos Test 3 — CPU Saturation:** Created an infinite CPU loop and observed that CPU consumption was constrained by the configured resource limit.

## Architecture

```text
                    Docker Host
                         |
                         v
              +-----------------------+
              |   resilient_service   |
              |                       |
              |     nginx:alpine      |
              |                       |
              | restart: always       |
              | CPU: 0.25             |
              | Memory: 128M          |
              | Healthcheck           |
              +-----------+-----------+
                          |
                          v
                    Port 8080
                          |
                       Browser


       Crash ───────────> Auto Restart
       Broken Page ────> Healthcheck → Unhealthy
       CPU Stress ─────> CPU Limit → Isolation
```

## Key Observations

| Chaos Test             | Failure Injected     | Expected Behavior                |
| ---------------------- | -------------------- | -------------------------------- |
| Container Termination  | Main process killed  | Container automatically restarts |
| Functional Degradation | `index.html` deleted | Healthcheck detects failure      |
| CPU Saturation         | Infinite CPU loop    | CPU usage remains constrained    |

## What I Understood

The experiment demonstrated that **container health cannot be determined only by checking whether the container is running**. Healthchecks provide application-level monitoring, restart policies provide automatic recovery after process failure, and resource limits prevent a misbehaving container from consuming excessive host resources.

## Conclusion

Successfully performed controlled chaos testing using Docker and Docker Compose. The experiment demonstrated **self-healing through restart policies, failure detection through healthchecks, and resource isolation through CPU limits**, improving the resilience of containerized services. 
