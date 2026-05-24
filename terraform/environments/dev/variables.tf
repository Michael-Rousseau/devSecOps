variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "project_name" {
  type    = string
  default = "deus-dashboard"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "db_username" {
  type    = string
  default = "deus_admin"
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "nasa_api_key" {
  type      = string
  sensitive = true
}

variable "ssh_key_name" {
  type = string
}

variable "my_ip_cidr" {
  type    = string
  default = "0.0.0.0/0"
}

variable "alert_email" {
  type    = string
  default = "michael.rousseau@flowdesk.co"
}

variable "backend_image_tag" {
  type    = string
  default = "latest"
}
