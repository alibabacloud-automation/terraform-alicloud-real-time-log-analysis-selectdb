# ------------------------------------------------------------------------------
# Complete Example for Real-time Log Analysis with SelectDB
#
# This example demonstrates how to use the real-time log analysis module
# with SelectDB. It includes all necessary data sources and variable
# assignments to create a complete working solution.
# ------------------------------------------------------------------------------

# Configure the Alibaba Cloud Provider
provider "alicloud" {
  region = "cn-hangzhou"
}

# Generate random suffix for resource naming
resource "random_integer" "suffix" {
  min = 1000
  max = 9999
}

# Get available zones
data "alicloud_zones" "default" {
  available_disk_category     = "cloud_essd"
  available_instance_type     = "ecs.g8i.4xlarge"
  available_resource_creation = "VSwitch"
}

# Get the latest Alibaba Cloud Linux image
data "alicloud_images" "default" {
  name_regex  = "^aliyun_3_9_x64_20G"
  owners      = "system"
  most_recent = true
}

# Use the real-time log analysis module
module "selectdb_log_analysis" {
  source = "../../"

  # VPC configuration
  vpc_config = {
    cidr_block = "192.168.0.0/16"
    vpc_name   = "selectdb-vpc-${random_integer.suffix.result}"
  }

  # VSwitch configuration
  vswitch_config = {
    zone_id      = data.alicloud_zones.default.zones[0].id
    cidr_block   = "192.168.0.0/24"
    vswitch_name = "selectdb-vswitch-${random_integer.suffix.result}"
  }

  # Security group configuration
  security_group_config = {
    security_group_name = "selectdb-sg-${random_integer.suffix.result}"
  }

  # ECS instance configuration
  instance_config = {
    image_id                   = data.alicloud_images.default.images[0].id
    instance_name              = "selectdb-ecs-${random_integer.suffix.result}"
    instance_type              = "ecs.g8i.4xlarge"
    system_disk_category       = "cloud_essd"
    system_disk_size           = 100
    internet_max_bandwidth_out = 10
    password                   = var.ecs_instance_password
  }

  # SelectDB instance configuration
  selectdb_config = {
    db_instance_description = "SelectDB instance for real-time log analysis - ${random_integer.suffix.result}"
    db_instance_class       = "selectdb.4xlarge"
    cache_size              = 100
    payment_type            = "PayAsYouGo"
    engine_minor_version    = "4.0.4"
    admin_pass              = var.selectdb_admin_password
    security_ip_group_name  = "default"
    security_ip_list        = "192.168.0.0/16"
  }

  # ECS command configuration
  ecs_command_config = {
    name        = "selectdb_setup_command_${random_integer.suffix.result}"
    description = "Setup command for SelectDB log analysis demo"
    type        = "RunShellScript"
    timeout     = 3600
    working_dir = "/root"
  }

  # ECS invocation configuration - Increased timeout for complex setup
  ecs_invocation_config = {
    create_timeout = "90m"
  }

  # Use default setup script (custom_ecs_command_script is not provided)

  # Tags configuration
  tags = {
    Name        = "selectdb-${random_integer.suffix.result}"
    Environment = "log-analysis"
    ManagedBy   = "Terraform"
  }
}