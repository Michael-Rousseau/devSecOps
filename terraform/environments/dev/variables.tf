# All non-secret values are injected via terraform.tfvars.
# Secrets are injected via environment: TF_VAR_db_password, TF_VAR_nasa_api_key.

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "project_name" {
  description = "Project name used to prefix resource names"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block of the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks of the public subnets. WARNING: changing replaces the subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks of the private subnets. WARNING: changing replaces the subnets"
  type        = list(string)
}

variable "ssh_key_name" {
  description = "EC2 key pair name (vockey in Learner Lab)"
  type        = string
}

variable "my_ip_cidr" {
  description = "CIDR allowed to reach bastion SSH and Grafana/Prometheus UIs"
  type        = string
}

variable "alert_email" {
  description = "Email subscribed to CloudWatch alarm notifications"
  type        = string
}

variable "db_username" {
  description = "Postgres master username"
  type        = string
}

variable "db_password" {
  description = "Postgres master password (TF_VAR_db_password)"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Postgres database name. WARNING: changing replaces the RDS instance"
  type        = string
}

variable "db_port" {
  description = "Postgres port"
  type        = number
  default     = 5432
}

variable "nasa_api_key" {
  description = "NASA API key (TF_VAR_nasa_api_key)"
  type        = string
  sensitive   = true
}

variable "backend_image_tag" {
  description = "Backend image tag to deploy"
  type        = string
  default     = "latest"
}

variable "rds_engine_version" {
  description = "Postgres engine version"
  type        = string
}

variable "rds_instance_class" {
  description = "RDS instance class"
  type        = string
}

variable "rds_allocated_storage" {
  description = "Initial RDS storage in GiB"
  type        = number
}

variable "rds_max_allocated_storage" {
  description = "RDS storage autoscaling ceiling in GiB"
  type        = number
}

variable "rds_multi_az" {
  description = "Enable RDS Multi-AZ standby"
  type        = bool
}

variable "rds_skip_final_snapshot" {
  description = "Skip final snapshot on destroy"
  type        = bool
}

variable "rds_backup_retention_days" {
  description = "RDS automated backup retention in days"
  type        = number
}

variable "ecs_instance_type" {
  description = "EC2 instance type of ECS container instances"
  type        = string
}

variable "bastion_instance_type" {
  description = "EC2 instance type of the bastion"
  type        = string
}

variable "monitoring_instance_type" {
  description = "EC2 instance type of the monitoring instance"
  type        = string
}

variable "asg_min_size" {
  description = "ECS Auto Scaling Group minimum size"
  type        = number
}

variable "asg_max_size" {
  description = "ECS Auto Scaling Group maximum size"
  type        = number
}

variable "asg_desired_capacity" {
  description = "ECS Auto Scaling Group desired capacity"
  type        = number
}

variable "service_desired_count" {
  description = "Number of backend tasks to run"
  type        = number
}

variable "deployment_minimum_healthy_percent" {
  description = "Minimum healthy task percent during deployments (100 = zero-downtime)"
  type        = number
}

variable "deployment_maximum_percent" {
  description = "Maximum task percent during deployments"
  type        = number
}

variable "container_port" {
  description = "Backend container port. WARNING: changing replaces the target group"
  type        = number
}

variable "task_cpu" {
  description = "CPU units reserved for the backend task"
  type        = number
}

variable "task_memory" {
  description = "Memory (MiB) reserved for the backend task"
  type        = number
}

variable "health_check_path" {
  description = "ALB health check path"
  type        = string
}

variable "log_retention_days" {
  description = "Backend log retention in days"
  type        = number
}
