output "frontend_url" {
  value = module.s3_frontend.website_endpoint
}

output "s3_bucket_name" {
  value = module.s3_frontend.s3_bucket_name
}

output "ecr_repository_url" {
  value = module.ecr.repository_url
}

output "ecs_cluster_name" {
  value = module.ecs.cluster_name
}

output "ecs_service_name" {
  value = module.ecs.service_name
}

output "alb_dns_name" {
  value = module.ecs.alb_dns_name
}

output "rds_endpoint" {
  value     = module.rds.rds_endpoint
  sensitive = true
}

output "bastion_public_ip" {
  value = module.bastion.bastion_public_ip
}

output "dynamodb_table_name" {
  value = module.dynamodb.table_name
}

output "grafana_url" {
  value = module.monitoring_stack.grafana_url
}

output "prometheus_url" {
  value = module.monitoring_stack.prometheus_url
}

output "monitoring_public_ip" {
  value = module.monitoring_stack.monitoring_public_ip
}
