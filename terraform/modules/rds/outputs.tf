output "rds_endpoint" {
  value = aws_db_instance.main.endpoint
}

output "rds_address" {
  value = aws_db_instance.main.address
}

output "db_name" {
  value = aws_db_instance.main.db_name
}

output "rds_instance_id" {
  value = aws_db_instance.main.identifier
}

output "rds_sg_id" {
  value = aws_security_group.rds.id
}
