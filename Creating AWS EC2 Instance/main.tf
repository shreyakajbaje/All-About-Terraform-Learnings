resource "aws_instance" "cerberus" {
    ami = var.ami
    instance_type = var.instance_type

    user_data = file("/root/terraform-projects/project-cerberus/install-nginx.sh")
    key_name = aws_key_pair.cerberus-key.id
}

# A new SSH key pair has been created in the directory /root/terraform-projects/project-cerberus/.ssh.
# The private key is called cerberus and the public key is called cerberus.pub

resource "aws_key_pair" "cerberus-key" {
    key_name = "cerberus"
    public_key = file("/root/terraform-projects/project-cerberus/.ssh/cerberus.pub")
}
# We use the public IPv4 address to access this server. However, when this server is rebooted or recreated, this IP address would change.
# To fix this, let's create an Elastic IP Address.
# An Elastic IP address is a static IPv4 address which does not change over time.

resource "aws_eip" "eip" {
    vpc = true
    instance = aws_instance.cerberus.id
    provisioner "local-exec" {
      command = "echo ${aws_eip.eip.public_dns} >> /root/cerberus_public_dns.txt"
    }
}
