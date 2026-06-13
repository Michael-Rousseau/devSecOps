variable "project_name" {
  description = "Project name used to prefix resource names"
  type        = string
}

variable "vpc_id" {
  description = "VPC where the bastion lives"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet hosting the bastion"
  type        = string
}

variable "ssh_key_name" {
  description = "EC2 key pair name for SSH access"
  type        = string
}

variable "my_ip_cidr" {
  description = "CIDR allowed to SSH into the bastion (no default: must be injected by the environment)"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type of the bastion"
  type        = string
  default     = "t2.micro"
}

variable "ami_name_filter" {
  description = "AMI name pattern. Note: most_recent=true means a new Amazon AMI release replaces the instance on the next apply (acceptable for a stateless bastion)"
  type        = string
  default     = "al2023-ami-*-x86_64"
}
