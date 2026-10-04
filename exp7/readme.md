# 🚀 Serverless Event Hooks with MinIO & FastAPI

> Cloud Systems / Serverless Computing Experiment

## 🎯 Aim

To implement and demonstrate a **serverless event-driven background compute function** that is automatically triggered when a file is uploaded to object storage.

**MinIO Object Storage → S3 Event → Webhook → FastAPI Worker**

The experiment demonstrates how asynchronous event notifications can trigger background computation without continuously polling the storage system.

---

## 🧩 What We Did

We built a Docker-based event-driven system using:

- **MinIO** — S3-compatible object storage and event producer
- **FastAPI** — Webhook that receives storage events
- **Python** — Background compute worker
- **Docker & Docker Compose** — Containerization and networking
- **MinIO Client (`mc`)** — Bucket and event configuration

When a file is uploaded to the `raw-uploads` bucket, MinIO generates an `ObjectCreated` event and sends an HTTP `POST` request to the FastAPI worker.

The worker receives the event and extracts:

- Event type
- Bucket name
- Object key
- Object size
- ETag

It then simulates a background processing task.

---

## 🏗️ System Architecture

```text
                         SERVERLESS EVENT HOOK
                                 │
                                 │
                         ┌───────▼───────┐
                         │     Client    │
                         │   File Upload │
                         └───────┬───────┘
                                 │
                              PUT Object
                                 │
                                 ▼
                    ┌────────────────────────┐
                    │         MinIO          │
                    │    Object Storage      │
                    │                        │
                    │    raw-uploads bucket  │
                    └───────────┬────────────┘
                                │
                         ObjectCreated Event
                                │
                                ▼
                    ┌────────────────────────┐
                    │   Event Notification   │
                    │       Webhook          │
                    └───────────┬────────────┘
                                │
                             HTTP POST
                                │
                                ▼
                    ┌────────────────────────┐
                    │      FastAPI Worker    │
                    │                        │
                    │ /webhook/s3-event      │
                    └───────────┬────────────┘
                                │
                         Background Compute
                                │
                                ▼
                    ┌────────────────────────┐
                    │ File Processing / ETL  │
                    │ Metadata Extraction    │
                    │ Virus Scan / etc.      │
                    └────────────────────────┘
```

---

## 🔄 Event Flow

```text
1. User uploads a file
          │
          ▼
2. MinIO stores the object
          │
          ▼
3. MinIO generates ObjectCreated event
          │
          ▼
4. Event dispatcher sends HTTP POST
          │
          ▼
5. FastAPI receives JSON event
          │
          ▼
6. Worker extracts object metadata
          │
          ▼
7. Background computation is executed
```

---

## 🐳 Docker Architecture

Both services run inside a shared Docker network called `event_net`.

```text
                  Docker Network: event_net
                  ─────────────────────────

        ┌──────────────────┐
        │      MinIO       │
        │                  │
        │ Port: 9000       │
        │ Console: 9001    │
        └────────┬─────────┘
                 │
                 │ HTTP POST
                 │
                 ▼
        ┌──────────────────┐
        │     Worker       │
        │                  │
        │    FastAPI       │
        │    Port: 5000    │
        └──────────────────┘
```

MinIO communicates with the worker using:

```text
http://worker:5000/webhook/s3-event
```

Here, `worker` is the Docker Compose service name.

---


### `worker.py`

Contains the FastAPI webhook endpoint:

```text
POST /webhook/s3-event
```

It receives and processes MinIO event notifications.

### `Dockerfile.worker`

Creates the Python environment containing FastAPI and Uvicorn.

### `docker-compose.yml`

Defines:

- MinIO service
- FastAPI worker
- Docker network
- MinIO webhook configuration

---


# 🔍 Polling vs Event-Driven Architecture

## ❌ Traditional Polling

```text
             ┌──────────────┐
             │ Cron / Script│
             └───────┬──────┘
                     │
                Check Storage
                     │
              ┌──────▼──────┐
              │ New File?   │
              └──────┬──────┘
                     │
              ┌──────┴───────┐
              │              │
             NO             YES
              │              │
              ▼              ▼
           Wait          Process File
              │
              └──────► Check Again
```

### Problems

- Repeated requests
- Unnecessary CPU usage
- Network overhead
- Processing delays
- Inefficient at scale

---

## ✅ Event-Driven Architecture

             File Upload
                   │
                   ▼
              ┌─────────┐
              │  MinIO  │
              └────┬────┘
                   │
              Event Generated
                   │
                   ▼
              HTTP Webhook
                   │
                   ▼
              ┌─────────┐
              │ Worker  │
              └────┬────┘
                   │
                   ▼
              Process File

- The worker remains idle until an event occurs.

## Key Concepts

1. Event-Driven Architecture (EDA)

In an event-driven architecture, components react to events instead of continuously checking for changes.