resource "aws_instance" "web" {
    ami           = "ami-0c6615d1e95c98aca"
    instance_type = "t3.micro"

    user_data = file("${path.module}/install.sh")

    tags = {
    Name = "aws-ec2-instance"
    }
}