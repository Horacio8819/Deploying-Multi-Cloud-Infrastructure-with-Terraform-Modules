variable "app_name" {
    description = "The name of the application."
    type        = string
    default = "my-app"
}

variable "environment" {
  description = "Deployment environment tag (dev, staging, prod)"
  type        = string
  default     = "dev"
}