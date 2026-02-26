terraform {
    backend "s3" {
        bucket = "terra-form-remote-state-devops-project"
        key = "global/s3/dev/terraform.tfstate"
        region = "ap-south-1"
        dynamodb_table = "backend-locks"
        encrypt = true
    }
}