variable "bucket_name"{
    default = "terra-form-remote-state-devops-project"
    type = string
}

variable "dynamodb_table_name"{
    default = "terraform-locks-table"
    type = string
}