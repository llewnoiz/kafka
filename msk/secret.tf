
resource "random_pet" "this" {
  length = 2
}



resource "aws_secretsmanager_secret" "this" {
  for_each = toset(local.secrets)

  name        = "AmazonMSK_${each.value}_${random_pet.this.id}"
  description = "Secret for ${local.name} - ${each.value}"
  kms_key_id  = aws_kms_key.this.key_id

  tags = local.tags
}

resource "aws_secretsmanager_secret_version" "this" {
  for_each = toset(local.secrets)

  secret_id = aws_secretsmanager_secret.this[each.key].id
  secret_string = jsonencode({
    username = each.value,
    password = "${each.key}123!" # do better!
  })
}

resource "aws_secretsmanager_secret_policy" "this" {
  for_each = toset(local.secrets)

  secret_arn = aws_secretsmanager_secret.this[each.key].arn
  policy     = <<-POLICY
  {
    "Version" : "2012-10-17",
    "Statement" : [ {
      "Sid": "AWSKafkaResourcePolicy",
      "Effect" : "Allow",
      "Principal" : {
        "Service" : "kafka.amazonaws.com"
      },
      "Action" : "secretsmanager:getSecretValue",
      "Resource" : "${aws_secretsmanager_secret.this[each.key].arn}"
    } ]
  }
  POLICY
}