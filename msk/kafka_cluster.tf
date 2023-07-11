

################################################################################
# MSK Cluster - Default
################################################################################

module "msk_cluster" {
  source = "./modules/terraform-aws-msk-kafka-cluster"

  name                   = local.name
  kafka_version          = "3.4.0"
  number_of_broker_nodes = 1

  broker_node_client_subnets  = module.vpc.private_subnets
  broker_node_instance_type   = "kafka.t3.small"
  broker_node_security_groups = [module.security_group.security_group_id]

  tags = local.tags

}

################################################################################
# MSK Cluster - Disabled
################################################################################

# module "msk_cluster_disabled" {
#   source = "./modules/terraform-aws-msk-kafka-cluster"

#   create = false
# }
