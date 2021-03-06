output "instance_public_ip" {
    description = "EC2 instance public ip"
    value = toset([
        for instance in aws_instance.web: instance.public_ip
    ])
}

output "instance_public_dns" {
    description = "EC2 instance public dns"
    value = toset(
        [for instance in aws_instance.web: instance.public_dns]
    )
}