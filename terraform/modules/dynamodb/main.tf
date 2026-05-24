resource "aws_dynamodb_table" "cache" {
  name         = "${var.project_name}-cache-${var.environment}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "cacheKey"

  attribute {
    name = "cacheKey"
    type = "S"
  }

  ttl {
    attribute_name = "ttl"
    enabled        = true
  }

  tags = { Name = "${var.project_name}-cache" }
}
