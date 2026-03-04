# ------------------------------------------------------------------------------
# Module Outputs
#
# This file defines the output values that will be returned when this module
# completes successfully. These outputs can be referenced by other Terraform
# configurations or displayed to users after the apply command.
# ------------------------------------------------------------------------------

# VPC outputs
output "vpc_id" {
  description = "The ID of the VPC."
  value       = alicloud_vpc.vpc.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC."
  value       = alicloud_vpc.vpc.cidr_block
}

# VSwitch outputs
output "vswitch_id" {
  description = "The ID of the VSwitch."
  value       = alicloud_vswitch.vswitch.id
}

output "vswitch_cidr_block" {
  description = "The CIDR block of the VSwitch."
  value       = alicloud_vswitch.vswitch.cidr_block
}

output "availability_zone" {
  description = "The availability zone of the VSwitch."
  value       = alicloud_vswitch.vswitch.zone_id
}

# Security Group outputs
output "security_group_id" {
  description = "The ID of the security group."
  value       = alicloud_security_group.security_group.id
}

# ECS Instance outputs
output "ecs_instance_id" {
  description = "The ID of the ECS instance."
  value       = alicloud_instance.ecs_instance.id
}

output "ecs_instance_name" {
  description = "The name of the ECS instance."
  value       = alicloud_instance.ecs_instance.instance_name
}

output "ecs_public_ip" {
  description = "The public IP address of the ECS instance."
  value       = alicloud_instance.ecs_instance.public_ip
}

output "ecs_private_ip" {
  description = "The private IP address of the ECS instance."
  value       = alicloud_instance.ecs_instance.primary_ip_address
}

# SelectDB Instance outputs
output "selectdb_instance_id" {
  description = "The ID of the SelectDB instance."
  value       = alicloud_selectdb_db_instance.selectdb_instance.id
}

output "selectdb_instance_description" {
  description = "The description of the SelectDB instance."
  value       = alicloud_selectdb_db_instance.selectdb_instance.db_instance_description
}

output "selectdb_connection_string" {
  description = "The VPC connection string of the SelectDB instance."
  value       = length(alicloud_selectdb_db_instance.selectdb_instance.instance_net_infos) > 1 ? alicloud_selectdb_db_instance.selectdb_instance.instance_net_infos[1].connection_string : null
}

output "selectdb_status" {
  description = "The status of the SelectDB instance."
  value       = alicloud_selectdb_db_instance.selectdb_instance.status
}

# ECS Command outputs
output "ecs_command_id" {
  description = "The ID of the ECS command."
  value       = alicloud_ecs_command.setup_command.id
}

output "ecs_invocation_id" {
  description = "The ID of the ECS command invocation."
  value       = alicloud_ecs_invocation.setup_invocation.id
}

# Login credentials (sensitive outputs)
output "ecs_login_user" {
  description = "The login username for the ECS instance."
  value       = "root"
}

output "selectdb_login_user" {
  description = "The login username for the SelectDB instance."
  value       = "admin"
}