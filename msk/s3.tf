module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.0"

  bucket_prefix = "${local.name}"
  acl           = "private"

  versioning = {
    enabled = true
  }
  object_ownership = "BucketOwnerPreferred"
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

resource "aws_s3_object" "debezium_connector" {
  bucket = module.s3_bucket.s3_bucket_id
  key    = local.connector
  source = local.connector

  depends_on = [
    null_resource.debezium_connector
  ]
}

resource "null_resource" "debezium_connector" {
  provisioner "local-exec" {
    command = <<-EOT
      wget ${local.connector_external_url} -O ${local.connector} 
    EOT
  }
}