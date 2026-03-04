# ------------------------------------------------------------------------------
# Example Outputs
#
# This file defines the output values from the complete example, demonstrating
# how to access and use the outputs from the real-time log analysis module.
# ------------------------------------------------------------------------------

# Infrastructure outputs
output "vpc_id" {
  description = "The ID of the created VPC."
  value       = module.selectdb_log_analysis.vpc_id
}

output "vswitch_id" {
  description = "The ID of the created VSwitch."
  value       = module.selectdb_log_analysis.vswitch_id
}

output "security_group_id" {
  description = "The ID of the created security group."
  value       = module.selectdb_log_analysis.security_group_id
}

# ECS instance outputs
output "ecs_instance_id" {
  description = "The ID of the ECS instance."
  value       = module.selectdb_log_analysis.ecs_instance_id
}

output "ecs_public_ip" {
  description = "The public IP address of the ECS instance."
  value       = module.selectdb_log_analysis.ecs_public_ip
}

output "ecs_private_ip" {
  description = "The private IP address of the ECS instance."
  value       = module.selectdb_log_analysis.ecs_private_ip
}

# SelectDB instance outputs
output "selectdb_instance_id" {
  description = "The ID of the SelectDB instance."
  value       = module.selectdb_log_analysis.selectdb_instance_id
}

output "selectdb_connection_string" {
  description = "The VPC connection string of the SelectDB instance."
  value       = module.selectdb_log_analysis.selectdb_connection_string
}

output "selectdb_status" {
  description = "The status of the SelectDB instance."
  value       = module.selectdb_log_analysis.selectdb_status
}

# Login information
output "ecs_login_user" {
  description = "The login username for the ECS instance."
  value       = module.selectdb_log_analysis.ecs_login_user
}

output "selectdb_login_user" {
  description = "The login username for the SelectDB instance."
  value       = module.selectdb_log_analysis.selectdb_login_user
}

# Command execution outputs
output "ecs_command_id" {
  description = "The ID of the ECS setup command."
  value       = module.selectdb_log_analysis.ecs_command_id
}

output "ecs_invocation_id" {
  description = "The ID of the ECS command invocation."
  value       = module.selectdb_log_analysis.ecs_invocation_id
}