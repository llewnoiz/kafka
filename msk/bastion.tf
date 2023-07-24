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
sudo apt-get install openjdk-11-jdk -y
echo "export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java))))" >> ~/.bashrc
echo "export PATH=$PATH:$JAVA_HOME/bin" >> ~/.bashrc
source ~/.bashrc

wget https://archive.apache.org/dist/kafka/2.8.1/kafka_2.12-2.8.1.tgz /home/ubuntu
git clone https://github.com/llewnoiz/kafka.git
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
  subnet_id = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  key_name = aws_key_pair.key_pair.key_name
  tags = local.tags

  lifecycle {
    ignore_changes = [ security_groups ]
  }
}