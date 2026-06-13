terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  }
}

locals {
  backend_log_group_name = "/ecs/${var.project_name}-backend"
}

module "vpc" {
  source               = "../../modules/vpc"
  project_name         = var.project_name
  aws_region           = var.aws_region
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "bastion" {
  source           = "../../modules/bastion"
  project_name     = var.project_name
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_a_id
  ssh_key_name     = var.ssh_key_name
  my_ip_cidr       = var.my_ip_cidr
  instance_type    = var.bastion_instance_type
}

module "ecr" {
  source       = "../../modules/ecr"
  project_name = var.project_name
}

module "s3_frontend" {
  source       = "../../modules/s3-frontend"
  project_name = var.project_name
  environment  = var.environment
}

moved {
  from = module.s3_cloudfront
  to   = module.s3_frontend
}

module "dynamodb" {
  source       = "../../modules/dynamodb"
  project_name = var.project_name
  environment  = var.environment
}

module "iam" {
  source = "../../modules/iam"
}

module "rds" {
  source             = "../../modules/rds"
  project_name       = var.project_name
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  bastion_sg_id      = module.bastion.bastion_sg_id

  db_name                 = var.db_name
  db_username             = var.db_username
  db_password             = var.db_password
  db_port                 = var.db_port
  engine_version          = var.rds_engine_version
  instance_class          = var.rds_instance_class
  allocated_storage       = var.rds_allocated_storage
  max_allocated_storage   = var.rds_max_allocated_storage
  multi_az                = var.rds_multi_az
  skip_final_snapshot     = var.rds_skip_final_snapshot
  backup_retention_period = var.rds_backup_retention_days
}

# Lives at the root because rds cannot reference the ecs module
# (ecs -> ssm -> rds would become a dependency cycle).
resource "aws_vpc_security_group_ingress_rule" "ecs_to_rds" {
  security_group_id            = module.rds.rds_sg_id
  referenced_security_group_id = module.ecs.ecs_sg_id
  from_port                    = var.db_port
  to_port                      = var.db_port
  ip_protocol                  = "tcp"
  description                  = "Postgres from ECS instances"
}

module "ssm" {
  source              = "../../modules/ssm"
  project_name        = var.project_name
  environment         = var.environment
  nasa_api_key        = var.nasa_api_key
  db_username         = var.db_username
  db_password         = var.db_password
  db_port             = var.db_port
  rds_address         = module.rds.rds_address
  db_name             = module.rds.db_name
  dynamodb_table_name = module.dynamodb.table_name
}

module "ecs" {
  source                    = "../../modules/ecs"
  project_name              = var.project_name
  environment               = var.environment
  aws_region                = var.aws_region
  vpc_id                    = module.vpc.vpc_id
  public_subnet_ids         = module.vpc.public_subnet_ids
  private_subnet_ids        = module.vpc.private_subnet_ids
  bastion_sg_id             = module.bastion.bastion_sg_id
  ssh_key_name              = var.ssh_key_name
  ecs_instance_profile_name = module.iam.ecs_instance_profile_name
  ecs_execution_role_arn    = module.iam.ecs_execution_role_arn
  ecs_task_role_arn         = module.iam.ecs_task_role_arn
  ecr_repository_url        = module.ecr.repository_url
  image_tag                 = var.backend_image_tag
  ssm_nasa_api_key_arn      = module.ssm.nasa_api_key_arn
  ssm_pg_host_arn           = module.ssm.pg_host_arn
  ssm_pg_password_arn       = module.ssm.pg_password_arn
  ssm_dynamodb_table_arn    = module.ssm.dynamodb_table_arn

  instance_type         = var.ecs_instance_type
  asg_min_size          = var.asg_min_size
  asg_max_size          = var.asg_max_size
  asg_desired_capacity  = var.asg_desired_capacity
  service_desired_count = var.service_desired_count

  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  deployment_maximum_percent         = var.deployment_maximum_percent
  container_port                     = var.container_port
  task_cpu                           = var.task_cpu
  task_memory                        = var.task_memory
  health_check_path                  = var.health_check_path
  log_group_name                     = local.backend_log_group_name
  db_name                            = module.rds.db_name
  db_username                        = var.db_username
  db_port                            = var.db_port
}

module "monitoring" {
  source             = "../../modules/monitoring"
  project_name       = var.project_name
  aws_region         = var.aws_region
  ecs_cluster_name   = module.ecs.cluster_name
  ecs_service_name   = module.ecs.service_name
  alb_arn_suffix     = module.ecs.alb_arn_suffix
  rds_instance_id    = module.rds.rds_instance_id
  alert_email        = var.alert_email
  log_group_name     = local.backend_log_group_name
  log_retention_days = var.log_retention_days
}

module "monitoring_stack" {
  source           = "../../modules/monitoring-stack"
  project_name     = var.project_name
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_a_id
  ssh_key_name     = var.ssh_key_name
  bastion_sg_id    = module.bastion.bastion_sg_id
  my_ip_cidr       = var.my_ip_cidr
  instance_type    = var.monitoring_instance_type
}
