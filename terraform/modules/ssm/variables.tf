variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "nasa_api_key" {
  type      = string
  sensitive = true
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "rds_address" {
  type = string
}

variable "db_name" {
  type = string
}

variable "dynamodb_table_name" {
  type = string
}

variable "db_port" {
  description = "Database port used in the connection string parameter"
  type        = number
  default     = 5432
}
