#key-paor for ec2
resource "aws_key_pair" "my_key" {
  key_name   = "terraform-key-prod"
  public_key = file("terrafrom-key-prod.pub")
  region     = "ap-south-1"

}

#using default vpc
resource "aws_default_vpc" "my_default_vpc" {

}

#creating a security group
resource "aws_security_group" "my_sg" {
  name        = "my_sg_prod"
  description = "This is the security group for terraform instance"
  vpc_id      = aws_default_vpc.my_default_vpc.id

  #creating ingress rule for port 22
  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
    description = "Inbound rules set for port 22"
  }
  #creating ingress rule for port 80
  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
    description = "Inbound rules set for port 80"
  }

  #creating egress rule
  egress {
    from_port   = 0
    protocol    = "-1" #"-1" -- > allows all protocols
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
    description = "Outbund rules set for all protocols"
  }
}

#creating an ec2 instance
resource "aws_instance" "my_instance" {
  key_name        = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.my_sg.name]
  instance_type   = var.ec2_instace
  ami             = var.ami_id
  root_block_device {
    volume_size = var.ec2_default_root_storage
    volume_type = var.ec2_default_root_storage_type
  }
  tags = {
    Name = "Terraform-EC2-PROD-ENV"
  }
}
