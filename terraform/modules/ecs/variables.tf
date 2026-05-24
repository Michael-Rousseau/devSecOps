variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "bastion_sg_id" {
  type = string
}

variable "ssh_key_name" {
  type = string
}

variable "ecs_instance_profile_name" {
  type = string
}

variable "ecs_execution_role_arn" {
  type = string
}

variable "ecs_task_role_arn" {
  type = string
}

variable "ecr_repository_url" {
  type = string
}

variable "image_tag" {
  type    = string
  default = "latest"
}

variable "ssm_nasa_api_key_arn" {
  type = string
}

variable "ssm_pg_host_arn" {
  type = string
}

variable "ssm_pg_password_arn" {
  type = string
}

variable "ssm_dynamodb_table_arn" {
  type = string
}
