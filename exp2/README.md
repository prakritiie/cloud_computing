# experiment 2 — VPC Creation Using Terraform

## Aim

To use **Terraform (Infrastructure as Code)** to create a secure Virtual Private Cloud (VPC) with **public and private subnets**, an Internet Gateway, route tables, and subnet associations in a local AWS-emulated environment.

## Important Terms

* **Terraform:** An Infrastructure as Code (IaC) tool used to define and provision infrastructure through configuration files.
* **Infrastructure as Code (IaC):** Managing infrastructure using code instead of manually configuring it.
* **VPC:** A Virtual Private Cloud is an isolated virtual network in a cloud environment.
* **CIDR:** Defines the IP address range of a network. Example: `10.0.0.0/16`.
* **Subnet:** A smaller network created inside a VPC.
* **Public Subnet:** A subnet whose route table has a route to an Internet Gateway.
* **Private Subnet:** A subnet without a direct route to the Internet Gateway, providing better isolation for internal resources.
* **Internet Gateway (IGW):** Connects a VPC to the Internet.
* **Route Table:** Contains rules that determine where network traffic should be sent.
* **Route:** A rule such as `0.0.0.0/0 → Internet Gateway` that directs Internet-bound traffic.
* **Route Table Association:** Connects a subnet to a specific route table.
* **Terraform Provider:** A plugin that allows Terraform to communicate with an infrastructure platform. Here, the AWS provider is used.
* **Terraform Plan:** Shows the infrastructure Terraform intends to create or modify before applying changes.
* **Terraform Apply:** Creates or modifies the infrastructure according to the Terraform configuration.
* **Terraform State:** Keeps track of the infrastructure resources managed by Terraform.

## What We Did

1. Created Terraform configuration files for the experiment.
2. Configured the AWS provider to communicate with the local AWS emulator through `localhost:4566`.
3. Defined a VPC with CIDR `10.0.0.0/16`.
4. Created a public subnet `10.0.1.0/24`.
5. Created a private subnet `10.0.2.0/24`.
6. Created an Internet Gateway.
7. Created separate public and private route tables.
8. Added an Internet route to the public route table.
9. Associated each subnet with its respective route table.
10. Used `terraform init` and `terraform plan` to verify the configuration before deployment.

## Architecture

```text
                    VPC
               10.0.0.0/16
                     |
          +----------+----------+
          |                     |
          v                     v
   Public Subnet          Private Subnet
   10.0.1.0/24            10.0.2.0/24
          |                     |
          v                     v
 Public Route Table      Private Route Table
          |
          | 0.0.0.0/0
          v
   Internet Gateway
          |
          v
       Internet
```

## Terraform Workflow

```text
Terraform Configuration
        |
        v
   terraform init
        |
        v
  terraform validate
        |
        v
   terraform plan
        |
        v
  terraform apply
        |
        v
 VPC + Subnets + Routes
```

## Result

Terraform successfully generated a plan for **8 resources**:

* 1 VPC
* 2 Subnets
* 1 Internet Gateway
* 2 Route Tables
* 2 Route Table Associations

The plan showed:

```text
Plan: 8 to add, 0 to change, 0 to destroy.
```

## What I Understood

This experiment demonstrated how Terraform can automatically create and manage cloud networking infrastructure instead of creating each resource manually. I understood that a **public subnet gets Internet connectivity through its route table and Internet Gateway**, while a **private subnet has no direct Internet Gateway route** and is therefore more isolated.

## Conclusion

Successfully used Terraform to define a VPC-based network architecture with separate public and private subnets. The experiment demonstrated **Infrastructure as Code, network segmentation, routing, and automated cloud resource provisioning** in a local AWS-emulated environment.
