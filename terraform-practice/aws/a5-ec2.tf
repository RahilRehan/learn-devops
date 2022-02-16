resource "aws_instance" "web" {

    count = 2

    ami           = data.aws_ami.amzlinux2.id
    instance_type = var.instance_type_list[count.index]

    user_data = file("${path.module}/install.sh")
    key_name = var.instance_keypair

    tags = {
        Name = "demo-instance-${count.index}"
    }

    vpc_security_group_ids = [aws_security_group.ssh.id, aws_security_group.web.id]
}