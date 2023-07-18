

################################################################################
# MSK Cluster - Default
################################################################################

module "msk_cluster" {
  source = "./modules/terraform-aws-msk-kafka-cluster"

  name                   = local.name
  kafka_version          = "2.8.1"
  number_of_broker_nodes = 2

  # broker_node_client_subnets  = module.vpc.public_subnets
  broker_node_client_subnets  = module.vpc.private_subnets
  broker_node_instance_type   = "kafka.t3.small"
  broker_node_security_groups = [module.security_group.security_group_id]

  client_authentication = {
    sasl = { scram = true }
  }

  encryption_in_transit_client_broker = "TLS"
  encryption_in_transit_in_cluster    = true
  broker_node_connectivity_info = {
    public_access = { type = local.public_access }
  }
  configuration_name        = "${local.name}-configuration"
  configuration_description = "${local.name} configuration"
  configuration_server_properties = {
    "auto.create.topics.enable" = true
    "delete.topic.enable"       = true
    # "allow.everyone.if.no.acl.found" = false
  }

  # create_scram_secret_association          = true
  # scram_secret_association_secret_arn_list = [for x in aws_secretsmanager_secret.this : x.arn]

  tags = local.tags

}
