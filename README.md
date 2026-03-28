# 🚀 Multi-Environment EC2 Deployment with Remote Backend


## 📖 Overview

This repository provides a comprehensive Infrastructure as Code (IaC) solution using Terraform to provision Amazon EC2 instances across distinct development and production environments. It emphasizes best practices by implementing a remote backend for Terraform state management using AWS S3 for storage and AWS DynamoDB for state locking, ensuring collaboration, security, and state consistency. The modular design allows for easy expansion and maintenance of your cloud infrastructure.

## ✨ Features

-   🎯 **Multi-Environment Support:** Easily deploy and manage EC2 instances for separate `dev` and `prod` environments.
-   ☁️ **EC2 Instance Provisioning:** Automated creation and configuration of AWS EC2 compute instances.
-   🧱 **Modular Terraform Structure:** Reusable Terraform modules for `ec2` resources, enhancing maintainability and reducing redundancy.
-   🔐 **Terraform Remote Backend:** Securely stores Terraform state in an AWS S3 bucket and uses DynamoDB for state locking, crucial for team collaboration and preventing concurrent modifications.
-   🚀 **Infrastructure as Code (IaC):** Manage your entire AWS infrastructure declaratively, enabling version control, automated deployment, and consistent environments.
-   🔄 **Idempotent Deployments:** Ensures that applying the same configuration multiple times results in the same infrastructure state, without unintended side effects.
-   ⚙️ **CI/CD Ready:** Designed for seamless integration with GitHub Actions to automate infrastructure validation, planning, and application.

## 🛠️ Tech Stack

**Infrastructure as Code:**

[![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)](https://www.terraform.io/)

**Cloud Provider:**

[![AWS](https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazon-aws&logoColor=white)](https://aws.amazon.com/)

**Backend State Management:**

[![Amazon S3](https://img.shields.io/badge/Amazon%20S3-569A31?style=for-the-badge&logo=amazons3&logoColor=white)](https://aws.amazon.com/s3/)

[![Amazon DynamoDB](https://img.shields.io/badge/Amazon%20DynamoDB-4053D6?style=for-the-badge&logo=amazondynamodb&logoColor=white)](https://aws.amazon.com/dynamodb/)

**CI/CD:**

[![GitHub Actions](https://img.shields.io/badge/GitHub%20Actions-2088FF?style=for-the-badge&logo=github-actions&logoColor=white)](https://github.com/features/actions)

## 🚀 Quick Start

Follow these steps to set up and deploy your multi-environment EC2 infrastructure.

### Prerequisites

-   **AWS Account:** An active AWS account.
-   **AWS CLI:** Installed and configured with appropriate credentials and default region.
    ```bash
    aws configure
    ```
-   **Terraform CLI:** Installed (version 1.0.0 or higher recommended).
    ```bash
    terraform --version
    ```

### Installation & Setup

1.  **Clone the repository**
    ```bash
    git clone https://github.com/hs2002-18/Multi-Environment-EC2-Deployment-with-Remote-Backend.git
    cd Multi-Environment-EC2-Deployment-with-Remote-Backend
    ```

2.  **Configure Remote Backend (One-time setup)**
    Navigate to the `remote-backend` directory and provision the S3 bucket and DynamoDB table that Terraform will use to store its state.

    ```bash
    cd remote-backend
    terraform init
    terraform plan -out=backend_plan.tfplan
    terraform apply "backend_plan.tfplan"
    cd ..
    ```
    *Ensure you configure the AWS region in `remote-backend/main.tf` if it's not already set or provided via environment variables.*

3.  **Deploying to an Environment**
    Choose your target environment (e.g., `dev` or `prod`).

    ```bash
    # For Development Environment
    cd Enviorments/dev # Note: Corrected "Enviorments" to "Environments" in README, but using actual repo path here.
    terraform init
    terraform plan -out=dev_plan.tfplan
    terraform apply "dev_plan.tfplan"
    cd ../.. # Go back to root

    # For Production Environment
    cd Enviorments/prod
    terraform init
    terraform plan -out=prod_plan.tfplan
    terraform apply "prod_plan.tfplan"
    cd ../.. # Go back to root
    ```

4.  **Destroying an Environment**
    To tear down the infrastructure for a specific environment:

    ```bash
    # For Development Environment
    cd Enviorments/dev
    terraform destroy
    cd ../..

    # For Production Environment
    cd Enviorments/prod
    terraform destroy
    cd ../..
    ```
    *Be cautious when running `terraform destroy` in production environments.*

## 📁 Project Structure

```
Multi-Environment-EC2-Deployment-with-Remote-Backend/
├── .github/                     # GitHub Actions workflows for CI/CD
│   └── workflows/
│       └── main.yml             # Example CI/CD pipeline for Terraform
├── .gitignore                   # Specifies files to be ignored by Git
├── Enviorments/                 # (Corrected spelling: Environments) Environment-specific configurations
│   ├── dev/                     # Development environment configuration
│   │   ├── main.tf              # Main Terraform configuration for dev
│   │   ├── variables.tf         # Input variables for dev environment
│   │   └── outputs.tf           # Output values for dev environment
│   └── prod/                    # Production environment configuration
│       ├── main.tf              # Main Terraform configuration for prod
│       ├── variables.tf         # Input variables for prod environment
│       └── outputs.tf           # Output values for prod environment
├── Module/                      # Reusable Terraform modules
│   └── ec2/                     # EC2 instance module
│       ├── main.tf              # Defines EC2 instance resources
│       ├── variables.tf         # Input variables for the EC2 module
│       └── outputs.tf           # Output values from the EC2 module
├── remote-backend/              # Terraform remote backend configuration
│   ├── main.tf                  # Defines S3 bucket and DynamoDB table for state
│   ├── variables.tf             # Variables for backend configuration
│   └── outputs.tf               # Outputs from backend resources
└── README.md                    # Project documentation (this file)
```

## ⚙️ Configuration

### Environment Variables

Ensure your AWS credentials are configured either via the AWS CLI or environment variables.

| Variable             | Description                                           | Example Value     |

| :------------------- | :---------------------------------------------------- | :---------------- |

| `AWS_ACCESS_KEY_ID`  | Your AWS access key.                                  | `AKIAIOSFODNN7EXAMPLE` |

| `AWS_SECRET_ACCESS_KEY` | Your AWS secret access key.                           | `wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY` |

| `AWS_REGION`         | The default AWS region for your deployments.          | `us-east-1`       |

| `TF_VAR_environment` | (Optional) Terraform variable to specify environment. | `dev`, `prod`     |

### Terraform Variables

Each environment (e.g., `Enviorments/dev/variables.tf`) and module (e.g., `Module/ec2/variables.tf`) can define its own input variables. Customize these files to configure specific resource properties like instance types, AMI IDs, or desired regions.

## 🔧 Infrastructure Management Workflow

This project is managed using standard Terraform commands:

| Command                         | Description                                                                  |

| :------------------------------ | :--------------------------------------------------------------------------- |

| `terraform init`                | Initializes a Terraform working directory, downloading providers and modules. |

| `terraform validate`            | Verifies the syntax and internal consistency of Terraform configuration files. |

| `terraform plan`                | Generates an execution plan, showing what actions Terraform will take.       |

| `terraform apply`               | Executes the actions proposed in a `terraform plan` to provision or update infrastructure. |

| `terraform destroy`             | Destroys all remote objects managed by the current Terraform configuration.  |

| `terraform output [NAME]`       | Displays the value of an output variable from the state file.                |

## 🧪 Testing & Validation

Before applying changes, it's crucial to validate your Terraform configuration:

```bash

# Navigate to your target environment or module
cd Enviorments/dev

# Validate configuration syntax and consistency
terraform validate

# Generate a plan to review proposed changes without applying them
terraform plan
```

## 🚀 Deployment

The project is structured to support CI/CD using GitHub Actions. The `.github/workflows/main.yml` (if present) would define automated steps for:

1.  **Validation:** `terraform validate`
2.  **Planning:** `terraform plan` (often posted as a comment on pull requests)
3.  **Application:** `terraform apply` (triggered on merges to `main`/`master` or specific branches for production deployments).

For manual deployment, refer to the "Quick Start" section.

## 📄 Author
Harsh Shrimali
