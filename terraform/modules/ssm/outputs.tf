output "nasa_api_key_arn" {
  value = aws_ssm_parameter.nasa_api_key.arn
}

output "pg_host_arn" {
  value = aws_ssm_parameter.pg_host.arn
}

output "pg_password_arn" {
  value = aws_ssm_parameter.pg_password.arn
}

output "dynamodb_table_arn" {
  value = aws_ssm_parameter.dynamodb_table.arn
}
