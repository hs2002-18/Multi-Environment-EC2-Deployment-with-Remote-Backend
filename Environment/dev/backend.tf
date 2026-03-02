terraform {
  backend "s3"{
    bucket = "terra-form-remote-state-devops-project"
    key = "dev/terraform.tf"
    region = "ap-south-1"
    dynamodb_table = "terraform-locks-table"
    encrypt = true
  }
}