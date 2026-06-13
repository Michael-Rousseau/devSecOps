# Dev environment values. Secrets are NOT stored here:
# export TF_VAR_db_password=... TF_VAR_nasa_api_key=...

aws_region   = "us-east-1"
project_name = "deus-dashboard"
environment  = "dev"

# Networking — WARNING: changing CIDRs on a live environment replaces the subnets
vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.10.0/24", "10.0.11.0/24"]

# Access
ssh_key_name = "vockey"    # fixed key pair provided by AWS Academy Learner Lab
my_ip_cidr   = "0.0.0.0/0" # Learner Lab convenience: client IPs rotate; restrict to <your-ip>/32 outside the lab

# Alerting
alert_email = "michael.rousseau@flowdesk.co"

# Database — WARNING: changing db_name replaces the RDS instance
db_username               = "deus_admin"
db_name                   = "deus_dashboard"
db_port                   = 5432
rds_engine_version        = "16.14"
rds_instance_class        = "db.t3.micro"
rds_allocated_storage     = 20
rds_max_allocated_storage = 50
rds_multi_az              = false
rds_skip_final_snapshot   = true
rds_backup_retention_days = 7

# Compute
ecs_instance_type        = "t2.small"
bastion_instance_type    = "t2.micro"
monitoring_instance_type = "t2.small"
asg_min_size             = 1
asg_max_size             = 2
asg_desired_capacity     = 1
service_desired_count    = 1

# Zero-downtime rolling deploys: new task starts (dynamic host port) before old one drains
deployment_minimum_healthy_percent = 100
deployment_maximum_percent         = 200

# Backend
container_port    = 3000
task_cpu          = 256
task_memory       = 384
health_check_path = "/api/health"

# Observability
log_retention_days = 14
