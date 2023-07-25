

################################################################################
# MSK Cluster - Default
################################################################################

module "msk_cluster" {
  source = "./modules/terraform-aws-msk-kafka-cluster"

  name                   = local.name
  kafka_version          = "2.8.1"
  number_of_broker_nodes = 2

  broker_node_client_subnets  = module.vpc.public_subnets
  # broker_node_client_subnets  = module.vpc.private_subnets
  broker_node_instance_type   = local.instance_type
  broker_node_security_groups = [module.security_group.security_group_id]

  encryption_in_transit_client_broker = "TLS"#"TLS" #"TLS_PLAINTEXT"
  encryption_in_transit_in_cluster    = true

  broker_node_storage_info = {
    ebs_storage_info = { volume_size = 30 }
  }

  client_authentication = {
    unauthenticated = false
    sasl = { 
      scram = true 
      iam = true 
    }
  }
  broker_node_connectivity_info = {
    public_access = { type = local.public_access }
  }
  configuration_name        = "${local.name}-configuration"
  configuration_description = "${local.name} configuration"
  configuration_server_properties = {
    "auto.create.topics.enable" = true
    "delete.topic.enable"       = true    
    "allow.everyone.if.no.acl.found"=false
    # "default.replication.factor"=3
    # "min.insync.replicas"=2s
    # "num.io.threads"=8
    # "num.network.threads"=5
    # "num.partitions"=1
    # "num.replica.fetchers"=2
    # "replica.lag.time.max.ms"=30000
    # "socket.receive.buffer.bytes"=102400
    # "socket.request.max.bytes"=104857600
    # "socket.send.buffer.bytes"=102400
    # "unclean.leader.election.enable"=true
    # "zookeeper.session.timeout.ms"=18000
  }

  create_scram_secret_association          = true
  scram_secret_association_secret_arn_list = [for x in aws_secretsmanager_secret.this : x.arn]

  tags = local.tags

}
