resource "aws_instance" "web" {
    ami           = data.aws_ami.amzlinux2.id
    instance_type = var.instance_type

    user_data = file("${path.module}/install.sh")
    key_name = var.instance_keypair

    tags = {
        Name = "aws-ec2-instance"
    }

    vpc_security_group_ids = [aws_security_group.ssh.id, aws_security_group.web.id]
}