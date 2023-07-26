module "s3_bucket" {
  source  = "./modules/terraform-aws-s3-bucket"

  bucket_prefix = "${local.name}-"
  acl           = "private"
  control_object_ownership = true
  object_ownership = "BucketOwnerPreferred"
  versioning = {
    enabled = true
  }  
  # Allow deletion of non-empty bucket for testing
  force_destroy = true

  attach_deny_insecure_transport_policy = true
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = local.tags
}

resource "aws_s3_object" "debezium_mssql_source_connector" {
  bucket = module.s3_bucket.s3_bucket_id
  key    = local.source_connector
  source = "${path.cwd}/connector/source/debezium-connector-sqlserver-2.3.0.Final.jar"
}

resource "aws_s3_object" "mysql_sink_connector" {
  bucket = module.s3_bucket.s3_bucket_id
  key    = local.sink_connector
  source = "${path.cwd}/connector/sink/mssql-jdbc-8.4.1.jre8.jar"
}
