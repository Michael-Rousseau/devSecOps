resource "aws_dynamodb_table" "cache" {
  name         = "${var.project_name}-cache-${var.environment}"
  billing_mode = var.billing_mode
  hash_key     = var.hash_key

  attribute {
    name = var.hash_key
    type = "S"
  }

  ttl {
    attribute_name = var.ttl_attribute
    enabled        = true
  }

  tags = { Name = "${var.project_name}-cache" }
}
