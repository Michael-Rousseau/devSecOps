variable "project_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnet_id" {
  type = string
}

variable "ssh_key_name" {
  type = string
}

variable "bastion_sg_id" {
  type = string
}

variable "my_ip_cidr" {
  type    = string
  default = "0.0.0.0/0"
}
