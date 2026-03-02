provider "aws" {
  region = "ap-south-1"
}
resource "aws_key_pair" "prod_key"{
  key_name = "prod-key"
  #  public_key = file("terraform.pub")  --> This is for local
#For CI we will use the below one and put the contents of key in Github Secret
public_key = var.public_key
}


module "ec2" {
  source        = "../../modules/ec2"
  instance_type = var.instance_type
  key_name      = aws_key_pair.prod_key.key_name
  env           = "prod"
  ami           = var.ami_id
  allowed_ip    = var.allowed_ip
}

output "dev_web_public_ip" {
  value = module.ec2.public_ip
}
