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
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
sudo apt-get update && sudo apt-get install docker-ce -y
sudo usermod -aG docker ubuntu
sudo service docker start
sudo chown -R $USER.docker /var/run/docker.sock
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash
source ~/.bashrc
nvm install 18

git clone https://github.com/tchiotludo/akhq.git
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
  instance_type = "t3.medium"
  user_data = local.instance-userdata
  
  root_block_device {
    volume_size = 100
  }

  security_groups = [ module.bastion_security_group.security_group_id ]
  subnet_id = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  key_name = aws_key_pair.key_pair.key_name
  tags = local.tags

  lifecycle {
    ignore_changes = [ security_groups ]
  }
}