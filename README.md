# Terraform Multi-Environment EC2 Deployment with Remote Backend


This repository provides a production-grade Infrastructure as Code (IaC) setup using Terraform to provision AWS infrastructure across separate Development (`dev`) and Production (`prod`) environments. It features a remote backend with state locking, a reusable EC2 module, and a CI/CD pipeline using GitHub Actions.

## Core Concepts & Features

*   **Multi-Environment Isolation:** Manages `dev` and `prod` environments independently, each with its own state file to prevent cross-environment interference.
*   **Remote State Management:** Utilizes AWS S3 to store the Terraform state file remotely and AWS DynamoDB for state locking, ensuring consistency and preventing race conditions in team environments.
*   **Modular Infrastructure:** Employs a reusable Terraform module for EC2 instances, abstracting the configuration for security groups, user data, and instance properties.
*   **CI/CD Automation:** Includes a GitHub Actions workflow that automates Terraform `init`, `validate`, `plan`, and `apply` for deploying infrastructure.
*   **Secure Networking:** Provisions AWS Security Groups to control inbound SSH (port 22) and HTTP (port 80) traffic.

## Project Structure

```
.
├── .github/
│   └── workflows/
│       └── terraform.yml       # CI/CD pipeline for automated deployment
├── Enviorments/
│   ├── dev/                    # Development environment configuration
│   │   ├── backend.tf
│   │   ├── main.tf
│   │   ├── terraform.tfvars
│   │   └── variables.tf
│   └── prod/                   # Production environment configuration
│       ├── backend.tf
│       ├── main.tf
│       ├── terraform.tfvars
│       └── variables.tf
├── Module/
│   └── ec2/                    # Reusable EC2 module
│       ├── main.tf             # Defines EC2 instance and security group
│       ├── outputs.tf
│       ├── user-data.sh        # Installs Nginx on instance launch
│       └── variables.tf
├── remote-backend/             # Configuration for the Terraform backend
│   ├── s3_backend.tf           # Defines the S3 bucket
│   ├── table_backend.tf        # Defines the DynamoDB table for state locking
│   └── ...
└── README.md
```

## How It Works

### Remote Backend

The foundation of this setup is the remote backend, configured in the `remote-backend` directory.
*   **AWS S3 Bucket (`s3_backend.tf`):** Stores the `terraform.tfstate` files. Versioning is enabled on the bucket to recover from accidental deletions or state corruption.
*   **AWS DynamoDB Table (`table_backend.tf`):** Provides a state locking mechanism. When a `terraform apply` is running, a lock is placed in this table, preventing others from running concurrent operations that could corrupt the state.

### Environments (`dev` & `prod`)

The `Enviorments` directory contains separate subdirectories for each environment. This isolation is achieved through the `backend.tf` file in each directory, which specifies a unique `key` for the state file in the S3 bucket:

*   **Dev:** `key = "dev/terraform.tf"`
*   **Prod:** `key = "prod/terraform.tf"`

This ensures that applying changes in the `dev` environment will never affect `prod` resources.

### EC2 Module

The `Module/ec2` directory contains a reusable module that provisions:
*   An `aws_instance` (EC2).
*   An `aws_security_group` that allows HTTP and SSH access.
*   A `user-data.sh` script that runs on first boot to update the instance and install an Nginx web server.

## Getting Started

### Prerequisites

*   AWS Account
*   Configured AWS CLI with an IAM user having necessary permissions.
*   Terraform installed locally.
*   An SSH key pair. If you don't have one, create it with `ssh-keygen -t rsa -b 4096`.

### Step 1: Set Up the Remote Backend

First, deploy the S3 bucket and DynamoDB table that will manage your Terraform state.

```sh
# Navigate to the remote backend directory
cd remote-backend

# Initialize Terraform
terraform init

# Apply the configuration to create the S3 bucket and DynamoDB table
terraform apply
```

### Step 2: Deploy an Environment

You can now deploy either the `dev` or `prod` environment. The steps are the same for both.

1.  **Navigate to the environment directory:**
    ```sh
    cd Enviorments/dev
    ```

2.  **Initialize Terraform:** This will connect to the remote backend you created in the previous step.
    ```sh
    terraform init
    ```

3.  **Plan and Apply:** Run `plan` to preview the changes and `apply` to create the resources. You will need to pass your public SSH key as a variable.

    ```sh
    # Plan the deployment
    terraform plan -var="public_key=$(cat ~/.ssh/id_rsa.pub)"

    # Apply the deployment
    terraform apply -var="public_key=$(cat ~/.ssh/id_rsa.pub)" -auto-approve
    ```
    Replace `~/.ssh/id_rsa.pub` with the path to your public SSH key. Upon completion, Terraform will output the public IP of the new EC2 instance.

## CI/CD Automation

This repository includes a GitHub Actions workflow defined in `.github/workflows/terraform.yml` to automate deployments.

### Workflow Triggers

*   **Manual Trigger (`workflow_dispatch`):** You can manually run the workflow from the "Actions" tab in GitHub and choose to deploy either the `dev` or `prod` environment.
*   **Push to `master`:** A push to the `master` branch will automatically trigger a deployment to the `dev` environment.

### Required GitHub Secrets

To enable the CI/CD pipeline, you must configure the following secrets in your GitHub repository settings (**Settings > Secrets and variables > Actions**):

*   `AWS_ACCESS_KEY`: Your AWS access key ID.
*   `AWS_SECRET_KEY`: Your AWS secret access key.
*   `PUBLIC_KEY`: The content of your public SSH key file (`id_rsa.pub`).

## Technologies Used

*   Terraform
*   AWS (EC2, S3, DynamoDB)
*   GitHub Actions
*   Shell Scripting (user data)

## Author

*   Harsh
