variable "lab_role_name" {
  description = "Pre-existing IAM role used for ECS execution/task roles (Learner Lab constraint)"
  type        = string
  default     = "LabRole"
}

variable "lab_instance_profile_name" {
  description = "Pre-existing instance profile attached to EC2 instances (Learner Lab constraint)"
  type        = string
  default     = "LabInstanceProfile"
}
