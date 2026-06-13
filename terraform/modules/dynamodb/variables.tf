variable "project_name" {
  description = "Project name used to prefix resource names"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, prod, ...)"
  type        = string
}

variable "billing_mode" {
  description = "DynamoDB billing mode"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "hash_key" {
  description = "Partition key attribute name. WARNING: changing on a live environment replaces the table"
  type        = string
  default     = "cacheKey"
}

variable "ttl_attribute" {
  description = "Attribute used for item TTL expiry"
  type        = string
  default     = "ttl"
}
