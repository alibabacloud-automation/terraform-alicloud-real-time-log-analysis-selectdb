# ------------------------------------------------------------------------------
# Real-time Log Analysis with SelectDB Solution
#
# This module creates a complete infrastructure for real-time log analysis
# using SelectDB, including VPC, VSwitch, Security Group, ECS instance,
# SelectDB instance, and automated setup scripts.
# ------------------------------------------------------------------------------

# Define locals for script extraction
locals {
  # Default initialization script for ECS instance
  default_ecs_command_script = <<-EOF
#!/bin/bash
cd /root
export ROS_DEPLOY=true
wget https://help-static-aliyun-doc.aliyuncs.com/install-script/selectdb-observability/yc_log_demo_2.0.1.tar.gz
tar -zxvf yc_log_demo_2.0.1.tar.gz
cd /root/log_demo
bash install.sh
sudo chown -R root:root /root/log_demo
EOF
}

# Create VPC for the solution
resource "alicloud_vpc" "vpc" {
  cidr_block = var.vpc_config.cidr_block
  vpc_name   = var.vpc_config.vpc_name
}

# Create VSwitch in the VPC
resource "alicloud_vswitch" "vswitch" {
  vpc_id       = alicloud_vpc.vpc.id
  zone_id      = var.vswitch_config.zone_id
  cidr_block   = var.vswitch_config.cidr_block
  vswitch_name = var.vswitch_config.vswitch_name
}

# Create security group for the solution
resource "alicloud_security_group" "security_group" {
  security_group_name = var.security_group_config.security_group_name
  vpc_id              = alicloud_vpc.vpc.id
}

# Create ECS instance for log processing
resource "alicloud_instance" "ecs_instance" {
  vpc_id                     = alicloud_vpc.vpc.id
  vswitch_id                 = alicloud_vswitch.vswitch.id
  security_groups            = [alicloud_security_group.security_group.id]
  image_id                   = var.instance_config.image_id
  instance_name              = var.instance_config.instance_name
  instance_type              = var.instance_config.instance_type
  system_disk_category       = var.instance_config.system_disk_category
  system_disk_size           = var.instance_config.system_disk_size
  internet_max_bandwidth_out = var.instance_config.internet_max_bandwidth_out
  password                   = var.instance_config.password

  tags = var.tags
}

# Create SelectDB instance for real-time analytics
resource "alicloud_selectdb_db_instance" "selectdb_instance" {
  vpc_id                  = alicloud_vpc.vpc.id
  zone_id                 = alicloud_vswitch.vswitch.zone_id
  vswitch_id              = alicloud_vswitch.vswitch.id
  db_instance_description = var.selectdb_config.db_instance_description
  db_instance_class       = var.selectdb_config.db_instance_class
  cache_size              = var.selectdb_config.cache_size
  payment_type            = var.selectdb_config.payment_type
  engine_minor_version    = var.selectdb_config.engine_minor_version
  admin_pass              = var.selectdb_config.admin_pass

  desired_security_ip_lists {
    group_name       = var.selectdb_config.security_ip_group_name
    security_ip_list = var.selectdb_config.security_ip_list
  }

  tags = var.tags
}

# Create ECS command for automated setup
resource "alicloud_ecs_command" "setup_command" {
  name            = var.ecs_command_config.name
  description     = var.ecs_command_config.description
  type            = var.ecs_command_config.type
  command_content = var.custom_ecs_command_script != null ? var.custom_ecs_command_script : base64encode(local.default_ecs_command_script)
  timeout         = var.ecs_command_config.timeout
  working_dir     = var.ecs_command_config.working_dir
}

# Execute the setup command on ECS instance
resource "alicloud_ecs_invocation" "setup_invocation" {
  instance_id = [alicloud_instance.ecs_instance.id]
  command_id  = alicloud_ecs_command.setup_command.id
  depends_on  = [alicloud_selectdb_db_instance.selectdb_instance]

  timeouts {
    create = var.ecs_invocation_config.create_timeout
  }
}