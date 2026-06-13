variable "project_name" {
  description = "Project name used to prefix resource names"
  type        = string
}

variable "vpc_id" {
  description = "VPC where the monitoring instance lives"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet hosting the monitoring instance"
  type        = string
}

variable "ssh_key_name" {
  description = "EC2 key pair name for SSH access"
  type        = string
}

variable "bastion_sg_id" {
  description = "Security group of the bastion host, allowed to SSH into the instance"
  type        = string
}

variable "my_ip_cidr" {
  description = "CIDR allowed to reach Grafana/Prometheus UIs (no default: must be injected by the environment)"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type of the monitoring instance"
  type        = string
  default     = "t2.small"
}

variable "ami_name_filter" {
  description = "AMI name pattern. Note: most_recent=true means a new Amazon AMI release replaces the instance on the next apply (re-run the monitoring playbook afterwards)"
  type        = string
  default     = "al2023-ami-*-x86_64"
}

variable "grafana_port" {
  description = "Grafana UI port"
  type        = number
  default     = 3000
}

variable "prometheus_port" {
  description = "Prometheus UI port"
  type        = number
  default     = 9090
}
