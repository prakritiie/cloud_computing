# experiment 3 — Terraform Remote State and State Locking

## Aim

To configure a centralized **PostgreSQL backend** for Terraform state management, implement **state locking**, and demonstrate safe concurrent Infrastructure as Code (IaC) operations.

## Important Terms

* **Terraform State:** Stores information about the infrastructure managed by Terraform.
* **Remote State:** Stores Terraform state in a centralized backend instead of a local `terraform.tfstate` file.
* **Terraform Backend:** Defines where Terraform stores and manages its state.
* **PostgreSQL:** Relational database used in this experiment to store Terraform's remote state.
* **Advisory Lock:** A database-level lock that prevents multiple Terraform operations from modifying the same state simultaneously.
* **State Locking:** Prevents concurrent Terraform operations from corrupting or overwriting shared state.
* **Race Condition:** A situation where simultaneous operations can produce incorrect or inconsistent results depending on their execution order.
* **Docker Compose:** Used to run the PostgreSQL backend as a local container.
* **IaC (Infrastructure as Code):** Managing infrastructure through configuration files instead of manual operations.
* **Concurrency Control:** Mechanism used to safely coordinate multiple operations accessing the same resource.

## What We Did

1. Created a PostgreSQL container using Docker Compose.
2. Configured PostgreSQL with a dedicated Terraform database and user.
3. Configured Terraform's `pg` backend to store state in PostgreSQL.
4. Ran `terraform init` to connect Terraform to the remote PostgreSQL backend.
5. Created a simulated infrastructure deployment with a 20-second delay.
6. Started `terraform apply` from two separate terminals to simulate two developers working simultaneously.
7. The first Terraform process acquired the PostgreSQL state lock.
8. The second process was prevented from modifying the state and returned a **state lock collision error**.
9. Verified that Terraform state was stored in the PostgreSQL database.

## Architecture

```text
             Developer A
                  |
           terraform apply
                  |
                  v
        +---------------------+
        |                     |
        |     PostgreSQL      |
        |                     |
        |  Terraform State    |
        |       +             |
        |   Advisory Lock     |
        |                     |
        +---------------------+
                  ^
                  |
           terraform apply
                  |
             Developer B

        A → Lock acquired 🔒
        B → Lock rejected ❌
```

## Terraform Workflow

```text
Docker Compose
      |
      v
PostgreSQL Backend
      |
      v
terraform init
      |
      v
Remote State Configured
      |
      v
Developer A → terraform apply → 🔒
Developer B → terraform apply → ❌
      |
      v
State safely stored in PostgreSQL
```

## Conclusion

Successfully configured PostgreSQL as a remote Terraform backend and demonstrated database-level state locking. The experiment showed how centralized state storage and advisory locks prevent simultaneous Terraform operations from corrupting shared infrastructure state, making IaC safer for team-based development.
