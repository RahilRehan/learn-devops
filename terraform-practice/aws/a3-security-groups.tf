resource "aws_security_group" "ssh" {
    name        = "ssh"
    description = "Allow SSH inbound traffic"

    ingress {
        description      = "Allow inbound port 22 traffic"
        from_port        = 22
        to_port          = 22
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
    }

    # we can have multiple ingress blocks

    egress {
        description      = "Allow all ips as outbound"
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
    }

    tags = {
        Name = "allow_ssh"
    }
}

# Allow outbound Web traffic
resource "aws_security_group" "web" {
    name        = "web"
    description = "Dev VPC web"
    ingress {
        description = "Allow Port 80"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "Allow Port 443"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

