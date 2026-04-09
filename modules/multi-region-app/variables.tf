variable "app_name" {
    description = "The name of the application."
    type        = string
}

variable "environment" {
  description = "Deployment environment tag (dev, staging, prod)"
  type        = string
  default     = "dev"
}