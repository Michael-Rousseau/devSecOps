variable "project_name" {
  description = "Project name used to prefix resource names"
  type        = string
}

variable "vpc_id" {
  description = "VPC where the database and its security group live"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnets for the DB subnet group"
  type        = list(string)
}

variable "bastion_sg_id" {
  description = "Security group of the bastion host, allowed to reach the database"
  type        = string
}

variable "db_username" {
  description = "Master username of the database"
  type        = string
}

variable "db_password" {
  description = "Master password of the database"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Name of the initial database. WARNING: changing on a live environment replaces the RDS instance"
  type        = string
}

variable "db_port" {
  description = "Database listening port"
  type        = number
  default     = 5432
}

variable "engine" {
  description = "Database engine"
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "Database engine version (upgrades happen in place)"
  type        = string
  default     = "16.14"
}

variable "instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Initial storage in GiB"
  type        = number
  default     = 20
}

variable "max_allocated_storage" {
  description = "Storage autoscaling ceiling in GiB"
  type        = number
  default     = 50
}

variable "storage_encrypted" {
  description = "Encrypt storage at rest. WARNING: changing on a live environment replaces the RDS instance"
  type        = bool
  default     = true
}

variable "multi_az" {
  description = "Enable Multi-AZ standby"
  type        = bool
  default     = false
}

variable "skip_final_snapshot" {
  description = "Skip the final snapshot on destroy (acceptable for dev only)"
  type        = bool
  default     = true
}

variable "backup_retention_period" {
  description = "Automated backup retention in days"
  type        = number
  default     = 7
}
