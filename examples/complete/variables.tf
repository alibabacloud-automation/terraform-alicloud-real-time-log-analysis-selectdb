# ------------------------------------------------------------------------------
# Example Variables
#
# This file defines the input variables required for the complete example
# of the real-time log analysis with SelectDB solution.
# ------------------------------------------------------------------------------

variable "ecs_instance_password" {
  type        = string
  description = "Password for the ECS instance root user."
  sensitive   = true

  validation {
    condition     = can(regex("^[0-9A-Za-z_!@#$%^&*()_+\\-=\\+]+$", var.ecs_instance_password)) && length(var.ecs_instance_password) >= 8 && length(var.ecs_instance_password) <= 30
    error_message = "Password must be 8-30 characters long and contain at least three of the following: uppercase letters, lowercase letters, numbers, and special characters (!@#$%^&*()_+-=)."
  }
}

variable "selectdb_admin_password" {
  type        = string
  description = "Password for the SelectDB admin user."
  sensitive   = true
  default     = "tf_example123"

  validation {
    condition     = can(regex("^[0-9A-Za-z_!@#$%^&*()_+\\-=\\+]+$", var.selectdb_admin_password)) && length(var.selectdb_admin_password) >= 8 && length(var.selectdb_admin_password) <= 30
    error_message = "Password must be 8-30 characters long and contain at least three of the following: uppercase letters, lowercase letters, numbers, and special characters (!@#$%^&*()_+-=)."
  }
}