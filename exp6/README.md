# experiment 6 — Kubernetes-Based Microservices Orchestration

## Aim

To deploy and manage a **multi-tier microservices application** using Kubernetes, demonstrating declarative configuration, service discovery, configuration management, and container orchestration. 

## Key Concepts

* **Kubernetes:** Container orchestration platform used to deploy, manage, and scale containerized applications.
* **Pod:** Smallest deployable unit in Kubernetes that contains one or more containers.
* **Deployment:** Manages Pods and maintains the desired number of replicas.
* **Service:** Provides a stable network endpoint for accessing Pods.
* **ClusterIP:** Exposes a service only inside the Kubernetes cluster.
* **NodePort:** Exposes a service externally through a port on the Kubernetes node.
* **ConfigMap:** Stores non-sensitive application configuration such as hostnames and ports.
* **Secret:** Stores sensitive configuration such as passwords and API keys.
* **Namespace:** Provides logical isolation for Kubernetes resources.
* **Service Discovery:** Kubernetes DNS allows services to communicate using names such as `backend-service` instead of Pod IP addresses. 

## What We Did

1. Created a local Kubernetes cluster using **Minikube**.
2. Created a `microservices-lab` Namespace.
3. Created a **ConfigMap** for application configuration and a **Secret** for credentials.
4. Deployed a **Redis database** with one replica.
5. Deployed the **backend service** with two replicas and exposed it internally using ClusterIP.
6. Deployed the **Nginx frontend** with two replicas and exposed it externally using NodePort `30080`.
7. Used ConfigMap and Secret values as environment variables inside the backend Pods.
8. Verified Kubernetes **service discovery** by accessing `backend-service:5000` from inside the cluster.
9. Verified the complete application using Kubernetes resource and service commands. 

## Architecture

```text
                    User / Browser
                         |
                    :30080
                         |
                 Frontend Service
                    NodePort
                         |
                 +-------+-------+
                 |               |
             Frontend         Frontend
                Pod              Pod
                 |
                 v
             Backend Service
                ClusterIP
                 |
             +---+---+
             |       |
          Backend  Backend
            Pod      Pod
             |
             v
          Database Service
             ClusterIP
                 |
               Redis
```

### Configuration Flow

```text
ConfigMap ──────┐
                ├──> Backend Pods
Secret ─────────┘
```

## Conclusion

Successfully deployed a **three-tier Kubernetes microservices architecture** with separate frontend, backend, and database tiers. The experiment demonstrated **declarative orchestration, replica management, internal service discovery, external access through NodePort, and separation of configuration from application code**. 
