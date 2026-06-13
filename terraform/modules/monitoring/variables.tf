variable "project_name" {
  description = "Project name used to prefix resource names"
  type        = string
}

variable "aws_region" {
  description = "AWS region used by the dashboard widgets"
  type        = string
}

variable "ecs_cluster_name" {
  description = "ECS cluster monitored by the alarms"
  type        = string
}

variable "ecs_service_name" {
  description = "ECS service monitored by the alarms"
  type        = string
}

variable "alb_arn_suffix" {
  description = "ALB ARN suffix used as CloudWatch dimension"
  type        = string
}

variable "rds_instance_id" {
  description = "RDS instance identifier used as CloudWatch dimension"
  type        = string
}

variable "alert_email" {
  description = "Email subscribed to the SNS alert topic"
  type        = string
}

variable "log_group_name" {
  description = "CloudWatch log group receiving backend container logs (must match the ECS task definition)"
  type        = string
}

variable "log_retention_days" {
  description = "Retention of backend container logs"
  type        = number
  default     = 14
}

variable "alarm_period" {
  description = "Evaluation period (seconds) for alarms and dashboard widgets"
  type        = number
  default     = 300
}

variable "ecs_cpu_threshold" {
  description = "ECS CPU utilization alarm threshold (%)"
  type        = number
  default     = 80
}

variable "ecs_memory_threshold" {
  description = "ECS memory utilization alarm threshold (%)"
  type        = number
  default     = 80
}

variable "alb_5xx_threshold" {
  description = "ALB 5xx count alarm threshold per period"
  type        = number
  default     = 10
}

variable "rds_cpu_threshold" {
  description = "RDS CPU utilization alarm threshold (%)"
  type        = number
  default     = 80
}

variable "rds_free_storage_threshold_bytes" {
  description = "RDS free storage alarm threshold in bytes"
  type        = number
  default     = 2000000000
}
