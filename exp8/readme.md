# Kubernetes Horizontal Pod Autoscaler (HPA)

## 🎯 Aim

To implement, configure, and evaluate the **Kubernetes Horizontal Pod Autoscaler (HPA)** using the Metrics Server and observe automatic Pod scaling under synthetic CPU load.

---

HPA = Horizontal Pod Autoscaler in Kubernetes.
In simple words:
HPA automatically increases or decreases the number of Pods based on workload.

## 🧩 Experiment Overview

In this experiment, we deployed a PHP-Apache application on a local **Minikube Kubernetes cluster**.

The application was configured with:

- CPU request: `200m`
- CPU limit: `500m`
- Minimum replicas: `1`
- Maximum replicas: `6`
- Target CPU utilization: `50%`

The **Metrics Server** continuously provides CPU usage metrics to Kubernetes. A BusyBox Pod was used as a synthetic load generator that continuously sent HTTP requests to the application.

When CPU utilization increased above the 50% target, the HPA automatically increased the number of application Pods.

After the load was stopped, CPU utilization decreased and the HPA automatically scaled the application back toward the minimum replica count.

---

## 🏗️ Architecture

```text
                       MINIKUBE CLUSTER
                              │
                              │
                    ┌─────────▼─────────┐
                    │   Load Generator  │
                    │      BusyBox      │
                    └─────────┬─────────┘
                              │
                         HTTP Requests
                              │
                              ▼
                    ┌───────────────────┐
                    │  PHP-Apache       │
                    │  Application Pods  │
                    │                   │
                    │  1 → 6 replicas    │
                    └─────────┬─────────┘
                              │
                         CPU Metrics
                              │
                              ▼
                    ┌───────────────────┐
                    │  Metrics Server   │
                    └─────────┬─────────┘
                              │
                       Metrics API
                              │
                              ▼
                    ┌───────────────────┐
                    │       HPA         │
                    │    Target: 50%    │
                    └─────────┬─────────┘
                              │
                              ▼
                       Scale Pods
                    1 → 2 → ... → 6

```


## flow

``` 
                    Application Idle
                           │
                           ▼
                        1 Pod
                           │
                           ▼
                 Generate HTTP Load
                           │
                           ▼
                    CPU Increases
                           │
                           ▼
                    Metrics Server
                           │
                           ▼
                         HPA
                           │
                    CPU > 50%
                           │
                           ▼
                     Scale Out
                           │
                    1 → 2 → ... → 6
                           │
                           ▼
                   Load Distributed
                           │
                           ▼
                 Stop Load Generator
                           │
                           ▼
                      CPU Drops
                           │
                           ▼
                  Stabilization Period
                           │
                           ▼
                     Scale Down
                           │
                    6 → 5 → ... → 1

```

## 🏁 Conclusion

The experiment successfully demonstrated Kubernetes Horizontal Pod Autoscaling.
The application automatically scaled from the baseline of 1 Pod toward a maximum of 6 Pods when synthetic CPU load was introduced. After the load was removed, CPU utilization decreased and the HPA automatically scaled the application back toward the minimum replica count.