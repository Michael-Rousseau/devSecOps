variable "project_name" {
  description = "Project name used to prefix resource names"
  type        = string
}

variable "aws_region" {
  description = "AWS region (combined with az_suffixes to build availability zones)"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block of the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks of the two public subnets. WARNING: changing on a live environment replaces the subnets and everything in them"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks of the two private subnets. WARNING: changing on a live environment replaces the subnets and everything in them"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24"]
}

variable "az_suffixes" {
  description = "Availability zone suffixes appended to aws_region (e.g. [\"a\", \"b\"]). WARNING: changing on a live environment replaces the subnets"
  type        = list(string)
  default     = ["a", "b"]
}
