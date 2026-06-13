variable "project_name" {
  description = "Project name used to prefix resource names"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, prod, ...)"
  type        = string
}

variable "aws_region" {
  description = "AWS region, injected into container env and log configuration"
  type        = string
}

variable "vpc_id" {
  description = "VPC where the cluster, ALB and security groups live"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnets for the ALB"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "Private subnets for the ECS container instances"
  type        = list(string)
}

variable "bastion_sg_id" {
  description = "Security group of the bastion host, allowed to SSH into ECS instances"
  type        = string
}

variable "ssh_key_name" {
  description = "EC2 key pair name for the container instances"
  type        = string
}

variable "ecs_instance_profile_name" {
  description = "Instance profile attached to the container instances"
  type        = string
}

variable "ecs_execution_role_arn" {
  description = "IAM role used by ECS to pull images and read secrets"
  type        = string
}

variable "ecs_task_role_arn" {
  description = "IAM role assumed by the running task"
  type        = string
}

variable "ecr_repository_url" {
  description = "ECR repository holding the backend image"
  type        = string
}

variable "image_tag" {
  description = "Backend image tag to deploy"
  type        = string
  default     = "latest"
}

variable "ssm_nasa_api_key_arn" {
  description = "SSM parameter ARN for the NASA API key"
  type        = string
}

variable "ssm_pg_host_arn" {
  description = "SSM parameter ARN for the Postgres host"
  type        = string
}

variable "ssm_pg_password_arn" {
  description = "SSM parameter ARN for the Postgres password"
  type        = string
}

variable "ssm_dynamodb_table_arn" {
  description = "SSM parameter ARN for the DynamoDB cache table name"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type of the ECS container instances"
  type        = string
  default     = "t2.small"
}

variable "asg_min_size" {
  description = "Auto Scaling Group minimum size"
  type        = number
  default     = 1
}

variable "asg_max_size" {
  description = "Auto Scaling Group maximum size"
  type        = number
  default     = 2
}

variable "asg_desired_capacity" {
  description = "Auto Scaling Group desired capacity"
  type        = number
  default     = 1
}

variable "service_desired_count" {
  description = "Number of backend tasks to run"
  type        = number
  default     = 1
}

variable "container_port" {
  description = "Port the backend container listens on. WARNING: changing replaces the target group"
  type        = number
  default     = 3000
}

variable "task_cpu" {
  description = "CPU units reserved for the backend task"
  type        = number
  default     = 256
}

variable "task_memory" {
  description = "Memory (MiB) reserved for the backend task"
  type        = number
  default     = 384
}

variable "health_check_path" {
  description = "HTTP path used by the ALB health check"
  type        = string
  default     = "/api/health"
}

variable "log_group_name" {
  description = "CloudWatch log group receiving backend container logs (must exist; see monitoring module)"
  type        = string
}

variable "db_name" {
  description = "Postgres database name injected into the container env"
  type        = string
}

variable "db_username" {
  description = "Postgres username injected into the container env"
  type        = string
}

variable "db_port" {
  description = "Postgres port injected into the container env"
  type        = number
  default     = 5432
}

variable "node_env" {
  description = "NODE_ENV value for the backend container"
  type        = string
  default     = "production"
}

variable "ecs_ami_ssm_parameter" {
  description = "SSM parameter resolving to the ECS-optimized AMI"
  type        = string
  default     = "/aws/service/ecs/optimized-ami/amazon-linux-2023/recommended/image_id"
}

variable "deployment_minimum_healthy_percent" {
  description = "Minimum healthy task percent during deployments (100 = zero-downtime rolling deploy)"
  type        = number
  default     = 100
}

variable "deployment_maximum_percent" {
  description = "Maximum task percent during deployments (200 allows the new task to start before the old one stops)"
  type        = number
  default     = 200
}

variable "container_insights" {
  description = "CloudWatch Container Insights setting (enabled/disabled)"
  type        = string
  default     = "enabled"
}
