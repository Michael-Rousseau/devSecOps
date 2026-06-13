output "monitoring_public_ip" {
  value = aws_instance.monitoring.public_ip
}

output "monitoring_sg_id" {
  value = aws_security_group.monitoring.id
}

output "grafana_url" {
  value = "http://${aws_instance.monitoring.public_ip}:${var.grafana_port}"
}

output "prometheus_url" {
  value = "http://${aws_instance.monitoring.public_ip}:${var.prometheus_port}"
}
