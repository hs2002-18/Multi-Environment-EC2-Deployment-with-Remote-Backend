# 🚀 Terraform Multi-Environment AWS Infrastructure (Dev & Prod)

This project demonstrates a production-style Infrastructure as Code (IaC) setup using Terraform to provision AWS EC2 infrastructure across separate Dev and Prod environments with remote state management.

---

## 🔹 Project Highlights
---
### Initial Version
- Multi-environment infrastructure (Dev & Prod)
- Remote state management using AWS S3
- State locking with DynamoDB
- Environment isolation to prevent accidental resource deletion
- Clean Git workflow with proper `.gitignore`
- Infrastructure fully reproducible using Terraform
---
### Updated Version
- Converted EC2 Configuration into a reusable module
- Added CI/CD Pipeine using GitHub Actions
- Implemented Security Groups

---

## 🏗 What This Project Provisions

Each environment deploys:

- Amazon EC2 Instance
- Security Group
- EC2 Key Pair
- Root EBS Volume
- Environment-based tagging

Infrastructure is isolated per environment using separate backend state paths.

---

## 📂 Project Structure
```bash
terraform-multi-env-project/
│
├── remote-backend/
│   ├── s3_backend.tf              # S3 bucket 
│   ├── table_backend.tf          # DynamoDB Table   
│   ├── variables.tf
│   ├── outputs.tf
│   ├── providers.tf
|
|
├── Module/
|    ├── ec2/
│     ├── main.tf           # EC2 instance, SG
│     ├── variables.tf          
│     ├── outputs..tf
│     ├── user-data.sh      # Bash script for installing Nginix
│    
├── Enviorments/
|     ├── dev-env/          # dev path
│       ├── main.tf              
│       ├── variables.tf
│       ├── backend.tf           
│       ├── terraform.tfvars 
|
|     ├── prod-env/          # prod path
│       ├── main.tf              
│       ├── variables.tf
│       ├── backend.tf           
│       ├── terraform.tfvars 
│   
├── .github/workflows
|      ├── terraform.yml
├── .gitignore
└── README.md
```

---

## 🔐 Remote Backend Architecture

- **Amazon S3** → Remote Terraform state storage  
- **DynamoDB** → State locking to prevent concurrent modifications  

This setup simulates real-world DevOps infrastructure management practices.

---

## 🛠 Technologies Used

- Terraform
- AWS EC2
- AWS S3
- AWS DynamoDB
- Git & GitHub

---

## 🎯 Key Concepts Demonstrated

- Infrastructure as Code (IaC)
- State management & locking
- Environment isolation
- Backend configuration
- Resource lifecycle management
- Git best practices for Terraform projects

---

## 📌 Future Enhancements

- Convert EC2 configuration into reusable Terraform modules
- Add CI/CD pipeline using GitHub Actions
- Implement VPC module
- Add monitoring and scaling

---

## 👨‍💻 Author
Harsh  

