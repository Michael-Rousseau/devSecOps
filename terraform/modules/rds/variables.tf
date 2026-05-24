variable "project_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.10.0/24", "10.0.11.0/24"]
}

variable "bastion_sg_id" {
  type = string
}

variable "db_username" {
  type    = string
  default = "deus_admin"
}

variable "db_password" {
  type      = string
  sensitive = true
}
