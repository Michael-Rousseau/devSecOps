variable "project_name" {
  description = "Project name used to prefix resource names"
  type        = string
}

variable "environment" {
  description = "Environment name, suffixed to the bucket name"
  type        = string
}
