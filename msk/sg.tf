module "security_group" {
  source  = "./modules/terraform-aws-security-group"
  # version = "~> 5.0"

  name        = local.name
  description = "Security group for ${local.name}"
  vpc_id      = module.vpc.vpc_id

  # ingress_cidr_blocks = module.vpc.public_subnets_cidr_blocks
  ingress_cidr_blocks = module.vpc.private_subnets_cidr_blocks
  ingress_rules = [
    "kafka-broker-tcp",
    "kafka-broker-tls-tcp",
    "kafka-broker-tls-public-tcp",
    "kafka-jmx-exporter-tcp",
    "kafka-node-exporter-tcp",
  ]  

    # kafka-broker-tcp                   = [9092, 9092, "tcp", "Kafka PLAINTEXT enable broker 0.8.2+"]
    # kafka-broker-tls-tcp               = [9094, 9094, "tcp", "Kafka TLS enabled broker 0.8.2+"]
    # kafka-broker-tls-public-tcp        = [9194, 9194, "tcp", "Kafka TLS Public enabled broker 0.8.2+ (MSK specific)"]
    # kafka-broker-sasl-scram-tcp        = [9096, 9096, "tcp", "Kafka SASL/SCRAM enabled broker (MSK specific)"]
    # kafka-broker-sasl-scram-public-tcp = [9196, 9196, "tcp", "Kafka SASL/SCRAM Public enabled broker (MSK specific)"]
    # kafka-broker-sasl-iam-tcp          = [9098, 9098, "tcp", "Kafka SASL/IAM access control enabled (MSK specific)"]
    # kafka-broker-sasl-iam-public-tcp   = [9198, 9198, "tcp", "Kafka SASL/IAM Public access control enabled (MSK specific)"]
    # kafka-jmx-exporter-tcp             = [11001, 11001, "tcp", "Kafka JMX Exporter"]
    # kafka-node-exporter-tcp            = [11002, 11002, "tcp", "Kafka Node Exporter"]
  egress_rules = [ "all-all" ]
  tags = local.tags
}


module "bastion_security_group" {
  source  = "./modules/terraform-aws-security-group"
  # version = "~> 5.0"

  name        = local.name
  description = "Security group for Bastion ${local.name}"
  vpc_id      = module.vpc.vpc_id

  # ingress_cidr_blocks = module.vpc.public_subnets_cidr_blocks
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules = [
    "ssh-tcp"
  ]  
  egress_rules = [ "all-all" ]
  tags = local.tags
}
