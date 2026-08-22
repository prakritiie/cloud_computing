# experiment 1 — Local Cloud Environment using Floci and MinIO

## Aim

To create a local AWS-compatible cloud environment using **Docker, Floci, MinIO, and AWS CLI**, and perform basic S3 operations such as creating buckets and uploading objects without using real AWS resources.

## Key Terms

* **Cloud Computing:** Delivery of computing resources such as storage, servers, and databases over a network.
* **AWS:** Amazon Web Services, a cloud platform providing services such as S3, EC2, and databases.
* **AWS S3:** AWS's object storage service that stores data as objects inside buckets.
* **AWS CLI:** Command-line tool used to interact with AWS services.
* **Docker:** Platform used to package and run applications in isolated containers.
* **Docker Image:** A packaged template containing everything required to run an application.
* **Docker Container:** A running instance of a Docker image.
* **Docker Compose:** Tool used to define and run multiple containers using a YAML configuration file.
* **Floci:** A lightweight local emulator that provides AWS-compatible APIs for development and testing without connecting to real AWS.
* **MinIO:** S3-compatible object storage that can run locally or on your own infrastructure.
* **S3 Bucket:** A container used to store objects/files.
* **Object:** A file and its associated metadata stored inside a bucket.
* **API:** A defined interface through which applications communicate with services.
* **Endpoint:** The address where a service's API can be accessed. In this experiment, Floci uses `localhost:4566` and MinIO uses `localhost:9000`.
* **`--endpoint-url`:** AWS CLI option used to redirect requests from real AWS to a local service.

## What We Did

1. Created a `compose.yaml` file defining Floci and MinIO containers.
2. Started both services using Docker Compose.
3. Configured AWS CLI with local/dummy credentials.
4. Used AWS CLI with a custom endpoint to create an S3 bucket through Floci.
5. Uploaded a sample file to the local bucket.
6. Created an S3-compatible bucket using MinIO.
7. Uploaded and verified the object through the MinIO web console.

## What I Understood

* **Floci acts as a local AWS environment**, allowing AWS-like APIs to be tested without using real AWS resources.
* **MinIO provides actual S3-compatible object storage locally.**
* AWS CLI does not always have to communicate with AWS; using `--endpoint-url`, requests can be redirected to local services.
* Docker makes it easy to run cloud-related services locally in isolated and reproducible containers.
* **MinIO is an alternative to AWS S3 for self-hosted storage**, while **Floci is mainly used for local AWS development and testing.**

## Architecture

```text
                    AWS CLI
                       |
              +--------+--------+
              |                 |
       localhost:4566     localhost:9000
              |                 |
            Floci             MinIO
        AWS API Emulator   S3-Compatible
                            Storage
                                |
                         localhost:9001
                                |
                         MinIO Console
```

## Conclusion

Successfully created a local cloud environment using Docker and demonstrated AWS-compatible bucket and object operations using Floci and MinIO without connecting to real AWS services.
