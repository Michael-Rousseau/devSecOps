variable "project_name" {
  description = "Project name used to prefix resource names"
  type        = string
}

variable "image_tag_mutability" {
  description = "ECR tag mutability (MUTABLE allows re-pushing the same tag, e.g. latest)"
  type        = string
  default     = "MUTABLE"
}

variable "scan_on_push" {
  description = "Scan images for vulnerabilities on push"
  type        = bool
  default     = true
}

variable "lifecycle_keep_last" {
  description = "Number of most recent images kept by the lifecycle policy"
  type        = number
  default     = 10
}
