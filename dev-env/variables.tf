variable "ec2_instace" {
    default = "t3.micro"
    type = string
}

variable "ec2_default_root_storage" {
    default = 8
    type = number
}

variable "ec2_default_root_storage_type" {
    default = "gp3"
    type = string
}

variable "ami_id" {
    default = "ami-019715e0d74f695be"
    type = string
}