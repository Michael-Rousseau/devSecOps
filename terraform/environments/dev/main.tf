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

module "vpc" {
  source       = "../../modules/vpc"
  project_name = var.project_name
  aws_region   = var.aws_region
  vpc_cidr     = var.vpc_cidr
}

module "bastion" {
  source           = "../../modules/bastion"
  project_name     = var.project_name
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_a_id
  ssh_key_name     = var.ssh_key_name
  my_ip_cidr       = var.my_ip_cidr
}

module "ecr" {
  source       = "../../modules/ecr"
  project_name = var.project_name
}

module "s3_cloudfront" {
  source       = "../../modules/s3-cloudfront"
  project_name = var.project_name
  environment  = var.environment
}

module "dynamodb" {
  source       = "../../modules/dynamodb"
  project_name = var.project_name
  environment  = var.environment
}

module "iam" {
  source             = "../../modules/iam"
  project_name       = var.project_name
  dynamodb_table_arn = module.dynamodb.table_arn
}

module "rds" {
  source               = "../../modules/rds"
  project_name         = var.project_name
  vpc_id               = module.vpc.vpc_id
  private_subnet_ids   = module.vpc.private_subnet_ids
  private_subnet_cidrs = ["10.0.10.0/24", "10.0.11.0/24"]
  bastion_sg_id        = module.bastion.bastion_sg_id
  db_username          = var.db_username
  db_password          = var.db_password
}

module "ssm" {
  source              = "../../modules/ssm"
  project_name        = var.project_name
  environment         = var.environment
  nasa_api_key        = var.nasa_api_key
  db_username         = var.db_username
  db_password         = var.db_password
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
}

module "monitoring" {
  source           = "../../modules/monitoring"
  project_name     = var.project_name
  aws_region       = var.aws_region
  ecs_cluster_name = module.ecs.cluster_name
  ecs_service_name = module.ecs.service_name
  alb_arn_suffix   = module.ecs.alb_arn_suffix
  rds_instance_id  = module.rds.rds_instance_id
  alert_email      = var.alert_email
}

module "monitoring_stack" {
  source           = "../../modules/monitoring-stack"
  project_name     = var.project_name
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_a_id
  ssh_key_name     = var.ssh_key_name
  bastion_sg_id    = module.bastion.bastion_sg_id
  my_ip_cidr       = var.my_ip_cidr
}
