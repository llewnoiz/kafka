locals{
  instance-userdata = <<EOF
#!/bin/bash

echo ${local_sensitive_file.private_key_pem.content} >> /home/ubuntu/.ssh/id_rsa
chmod 600 /home/ubuntu/.ssh/id_rsa
sudo chown -R ubuntu.ubuntu /home/ubuntu/.ssh/id_rsa
sudo systemctl restart ssh

mkdir /home/ubuntu/build
cd /home/ubuntu

sudo apt update -y
EOF

depend_on = [local_sensitive_file.private_key_pem]
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  security_groups = [ module.bastion_security_group.security_group_id ]
  subnet_id = module.vpc.private_subnets[0]
  associate_public_ip_address = true
  key_name = aws_key_pair.key_pair.key_name
  tags = local.tags
}