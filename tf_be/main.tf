# backend.tf

provider "aws" {
  region = var.region
  profile = var.profile
}

# S3 버킷을 생성한다
resource "aws_s3_bucket" "tfstate" {
  bucket = local.tfstate_bucket

  tags = local.tags
}

# S3 버킷의 버저닝 기능 활성화 선언한다.
resource "aws_s3_bucket_versioning" "tfstate" {
  bucket = aws_s3_bucket.tfstate.bucket

  versioning_configuration {
    status = "Enabled"
  }
}

# DynamoDB for terraform state lock
resource "aws_dynamodb_table" "terraform_state_lock" {
  name         =  local.terraform_state_lock
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
  tags = local.tags
}