resource "aws_ssm_parameter" "nasa_api_key" {
  name  = "/${var.project_name}/${var.environment}/nasa-api-key"
  type  = "SecureString"
  value = var.nasa_api_key
  tags  = { Name = "${var.project_name}-nasa-api-key" }
}

resource "aws_ssm_parameter" "database_url" {
  name  = "/${var.project_name}/${var.environment}/database-url"
  type  = "SecureString"
  value = "postgresql://${var.db_username}:${var.db_password}@${var.rds_address}:5432/${var.db_name}"
  tags  = { Name = "${var.project_name}-database-url" }
}

resource "aws_ssm_parameter" "pg_host" {
  name  = "/${var.project_name}/${var.environment}/pg-host"
  type  = "String"
  value = var.rds_address
  tags  = { Name = "${var.project_name}-pg-host" }
}

resource "aws_ssm_parameter" "pg_password" {
  name  = "/${var.project_name}/${var.environment}/pg-password"
  type  = "SecureString"
  value = var.db_password
  tags  = { Name = "${var.project_name}-pg-password" }
}

resource "aws_ssm_parameter" "dynamodb_table" {
  name  = "/${var.project_name}/${var.environment}/dynamodb-table"
  type  = "String"
  value = var.dynamodb_table_name
  tags  = { Name = "${var.project_name}-dynamodb-table" }
}
