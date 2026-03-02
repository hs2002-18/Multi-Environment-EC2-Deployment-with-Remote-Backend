resource "aws_security_group" "my_sg"{
    name = "${var.env}-sg"

    ingress{
        from_port = 80
        to_port = 80
        protocol = "tcp"
        description = "HTTP"
        cidr_blocks = var.allowed_ip
    }

    ingress{
        from_port = 22
        to_port = 22
        protocol = "tcp"
        description = "SSH"
        cidr_blocks = var.allowed_ip
    }

    egress{
        from_port = 0
        to_port = 0
        protocol = -1
        description = "ALL"
        cidr_blocks = ["0.0.0.0/0"]
    }

}

resource "aws_instance" "web"{
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.my_sg.id]
    user_data = file("${path.module}/user-data.sh")

    tags = {
        Name= "${var.env}-WebServer"
        Environment = var.env
    }
}