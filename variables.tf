# ------------------------------------------------------------------------------
# Module Variables
#
# This file defines all configurable input variables for the real-time log
# analysis with SelectDB solution module. Each variable includes type,
# description, and default values where appropriate.
# ------------------------------------------------------------------------------

variable "vpc_config" {
  type = object({
    cidr_block = string
    vpc_name   = optional(string, "selectdb-vpc")
  })
  description = "Configuration for the VPC. The 'cidr_block' attribute is required."
}

variable "vswitch_config" {
  type = object({
    zone_id      = string
    cidr_block   = string
    vswitch_name = optional(string, "selectdb-vswitch")
  })
  description = "Configuration for the VSwitch. The 'zone_id' and 'cidr_block' attributes are required."
}

variable "security_group_config" {
  type = object({
    security_group_name = optional(string, "selectdb-sg")
  })
  description = "Configuration for the security group."
  default     = {}
}

variable "instance_config" {
  type = object({
    image_id                   = string
    instance_name              = optional(string, "selectdb-ecs")
    instance_type              = optional(string, "ecs.g8i.4xlarge")
    system_disk_category       = optional(string, "cloud_essd")
    system_disk_size           = optional(number, 100)
    internet_max_bandwidth_out = optional(number, 10)
    password                   = string
  })
  description = "Configuration for the ECS instance. The 'image_id' and 'password' attributes are required."
}

variable "selectdb_config" {
  type = object({
    db_instance_description = optional(string, "SelectDB instance for real-time log analysis")
    db_instance_class       = optional(string, "selectdb.4xlarge")
    cache_size              = optional(number, 100)
    payment_type            = optional(string, "PayAsYouGo")
    engine_minor_version    = optional(string, "4.0.4")
    admin_pass              = string
    security_ip_group_name  = optional(string, "default")
    security_ip_list        = optional(string, "192.168.0.0/16")
  })
  description = "Configuration for the SelectDB instance. The 'admin_pass' attribute is required."
}

variable "ecs_command_config" {
  type = object({
    name        = optional(string, "selectdb_setup_command")
    description = optional(string, "Setup command for SelectDB log analysis demo")
    type        = optional(string, "RunShellScript")
    timeout     = optional(number, 3600)
    working_dir = optional(string, "/root")
  })
  description = "Configuration for the ECS command used for automated setup."
  default     = {}
}

variable "ecs_invocation_config" {
  type = object({
    create_timeout = optional(string, "60m")
  })
  description = "Configuration for the ECS command invocation timeouts."
  default     = {}
}

variable "custom_ecs_command_script" {
  type        = string
  description = "Custom ECS command script. If not provided, the default SelectDB setup script will be used."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to resources."
  default = {
    Environment = "log-analysis"
    ManagedBy   = "Terraform"
  }
}