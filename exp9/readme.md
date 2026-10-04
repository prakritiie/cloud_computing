# Experiment 9: DevSecOps Static Security Analysis using Trivy and Checkov

## Aim

To design and implement a DevSecOps static security analysis pipeline using **Trivy** and **Checkov** to detect security misconfigurations, vulnerable dependencies, and hardcoded secrets before deployment.

---

## Tools Used

- Docker
- Trivy
- Checkov
- Terraform
- Python & pip
- Git
- VS Code

---

## DevSecOps Workflow

```text
Developer
    |
    v
Source Code / IaC
    |
    +-------------------+
    |                   |
    v                   v
  Trivy              Checkov
    |                   |
    | Secret Scan       | IaC Scan
    | Config Scan       | Dockerfile
    |                   | Terraform
    v                   v
    +---------+---------+
              |
              v
        Security Gate
              |
        +-----+-----+
        |           |
      PASS         FAIL
        |           |
        v           v
     Deploy      Fix Issues

```

1. Insecure Dockerfile
The initial Dockerfile intentionally contained security issues such as:
- Hardcoded AWS credentials
- Running the container as root
- Unnecessary exposure of port 80

2. Insecure Terraform Configuration
The Terraform configuration contained intentionally insecure settings:
- S3 bucket without encryption
- SSH port 22 exposed to 0.0.0.0/0

3. Checkov Scan
Checkov was used to scan Terraform and Dockerfile configurations.

Checkov can detect issues such as:
- Containers running as root
- Unrestricted network access
- Unencrypted storage
- Insecure Terraform configurations

4. Trivy Scan
Trivy was used to detect secrets and configuration vulnerabilities.

Trivy can scan:
- Container images
- Filesystems
- Terraform
- Kubernetes manifests
- Dockerfiles
- Application dependencies
- Hardcoded secrets

##  Post-Lab Questions

1. Why detect hardcoded secrets before Git commit instead of deleting them later?
Deleting a secret later does not necessarily remove it from Git history. The secret may already exist in commits, clones, CI logs, caches, or other systems.
Therefore, secrets should be detected before they are committed.
If a real credential is accidentally committed, it should also be revoked/rotated immediately.
2. How do CI/CD exit codes integrate with GitHub/GitLab branch protection?
Security tools return a non-zero exit code when a critical issue is found.

