terraform {
  backend "s3"{
    bucket = "terra-form-remote-state-devops-project"
    key = "prod/terraform.tf"
    region = "ap-south-1"
    dynamodb_table = "locks-table"
    encrypt = true
  }
}