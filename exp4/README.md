# experiment 4 — Docker Image Optimization and Container Security

## Aim

To optimize a Dockerized Node.js microservice using multi-stage builds, Alpine Linux, layer caching, and non-root execution, and compare it with a naive Docker image.

## Important Terms

- **Docker Image:** Packaged template containing an application and its dependencies.
- **Docker Container:** Running instance of a Docker image.
- **Multi-stage Build:** Uses multiple build stages so that only the required files are included in the final image.
- **Alpine Linux:** Lightweight Linux distribution used to reduce Docker image size.
- **Layer Caching:** Docker reuses unchanged build layers to make subsequent builds faster.
- **Non-root User:** Runs the application with limited privileges instead of the `root` user.
- **Production Dependency:** Dependency required to run the application in production.
- **Attack Surface:** The number of components that could potentially be exploited.

## What We Did

1. Created a Node.js microservice using Express.
2. Created a **naive Dockerfile** using `node:20`.
3. Built the naive Docker image and checked its size and runtime user.
4. Created an optimized **multi-stage Dockerfile** using `node:20-alpine`.
5. Installed only production dependencies in the optimized image.
6. Used Docker layer caching by copying `package*.json` before application source code.
7. Created and used a non-root `appuser`.
8. Built and compared the naive and optimized images.
9. Verified the container user using `docker exec ... whoami`.
10. Tested the application through the `/` endpoint.

## Architecture

```text
                 Node.js Application
                         |
                 +-------+-------+
                 |               |
                 v               v
           Naive Image     Optimized Image
                 |               |
              node:20      Multi-stage Build
                 |               |
               ROOT        node:20-alpine
                                 |
                            appuser
                                 |
                         Smaller + Safer



