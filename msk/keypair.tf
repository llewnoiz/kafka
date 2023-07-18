resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key_pair" {
  key_name = "test_key_pair"
  public_key = tls_private_key.private_key.public_key_openssh
}

resource "local_sensitive_file" "private_key_pem" {
  content = tls_private_key.private_key.private_key_pem
  file_permission = "0400"
  filename = "../private-key.pem"
}


output "private_pem_key_name" {
  description = "key name"
  value = nonsensitive(local_sensitive_file.private_key_pem.content)
}