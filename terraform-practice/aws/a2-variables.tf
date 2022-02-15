variable aws_region {
    description = "AWS region"
    type = string
    default = "ap-south-1"
}

variable instance_type {
    description = "EC2 instance type"
    type = string
    default = "t3.micro"
}

variable instance_keypair {
    description = "AWS instance keypair which will be attached to EC2 instance"
    type = string
    default = "catalyst-demo"
}