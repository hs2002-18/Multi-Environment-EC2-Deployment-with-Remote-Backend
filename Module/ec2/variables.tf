variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}

variable "ami" {
  type = string
}

variable "env"{
    type = string
}

variable "allowed_ip" {
  type = list(string)
}