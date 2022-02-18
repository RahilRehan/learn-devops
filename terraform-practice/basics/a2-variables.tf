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

variable instance_type_list {
    description = "EC2 instance type"
    type = list(string)
    default = ["t3.micro","t3.small"]
}

variable instance_type_map {
    description = "EC2 instance type"
    type = map(string)
    default = {
        "dev" : "t3.micro",
        "qa" : "t3.small",
        "prod" : "t3.large"
    }
}

variable instance_keypair {
    description = "AWS instance keypair which will be attached to EC2 instance"
    type = string
    default = "catalyst-demo"
}