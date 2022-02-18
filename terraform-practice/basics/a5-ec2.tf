resource "aws_instance" "web" {
    ami           = data.aws_ami.amzlinux2.id

    for_each = toset(data.aws_availability_zones.my_azones.names)
    availability_zone = each.key
    instance_type = var.instance_type

    user_data = file("${path.module}/install.sh")
    key_name = var.instance_keypair

    tags = {
        Name = "demo-instance-${each.key}"
    }

    vpc_security_group_ids = [aws_security_group.ssh.id, aws_security_group.web.id]
}