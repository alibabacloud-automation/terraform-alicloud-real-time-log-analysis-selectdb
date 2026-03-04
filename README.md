Alibaba Cloud Real-time Log Analysis with SelectDB Terraform Module

# terraform-alicloud-real-time-log-analysis-selectdb

English | [简体中文](https://github.com/alibabacloud-automation/terraform-alicloud-real-time-log-analysis-selectdb/blob/main/README-CN.md)

This Terraform module creates a complete infrastructure for real-time log analysis using SelectDB on Alibaba Cloud. The module implements the [SelectDB enables efficient log storage and real-time analytics](https://www.aliyun.com/solution/tech-solution/real-time-log-analysis-with-selectdb) solution, which provides efficient log storage and real-time analytics capabilities. It creates a VPC network, ECS instance for log processing, SelectDB database instance for analytics, and includes automated setup scripts for the log analysis demo.

## Usage

To use this module, you need to provide the required configuration parameters including VPC settings, ECS instance specifications, and SelectDB database configuration. The module will create all necessary infrastructure and automatically set up the log analysis demo environment.

```terraform
module "selectdb_log_analysis" {
  source = "alibabacloud-automation/real-time-log-analysis-selectdb/alicloud"

  # VPC configuration
  vpc_config = {
    cidr_block = "192.168.0.0/16"
  }

  # VSwitch configuration
  vswitch_config = {
    zone_id    = "cn-hangzhou-h"
    cidr_block = "192.168.0.0/24"
  }

  # ECS instance configuration
  instance_config = {
    image_id = "aliyun_3_x64_20G_alibase_20240819.vhd"
    password = "YourSecurePassword123!"
  }

  # SelectDB instance configuration
  selectdb_config = {
    admin_pass = "YourSelectDBPassword123!"
  }
}
```

## Examples

* [Complete Example](https://github.com/alibabacloud-automation/terraform-alicloud-real-time-log-analysis-selectdb/tree/main/examples/complete)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.229.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | >= 1.229.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_ecs_command.setup_command](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_invocation.setup_invocation](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_instance.ecs_instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_security_group.security_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_selectdb_db_instance.selectdb_instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/selectdb_db_instance) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_custom_ecs_command_script"></a> [custom\_ecs\_command\_script](#input\_custom\_ecs\_command\_script) | Custom ECS command script. If not provided, the default SelectDB setup script will be used. | `string` | `null` | no |
| <a name="input_ecs_command_config"></a> [ecs\_command\_config](#input\_ecs\_command\_config) | Configuration for the ECS command used for automated setup. | <pre>object({<br/>    name        = optional(string, "selectdb_setup_command")<br/>    description = optional(string, "Setup command for SelectDB log analysis demo")<br/>    type        = optional(string, "RunShellScript")<br/>    timeout     = optional(number, 3600)<br/>    working_dir = optional(string, "/root")<br/>  })</pre> | `{}` | no |
| <a name="input_ecs_invocation_config"></a> [ecs\_invocation\_config](#input\_ecs\_invocation\_config) | Configuration for the ECS command invocation timeouts. | <pre>object({<br/>    create_timeout = optional(string, "60m")<br/>  })</pre> | `{}` | no |
| <a name="input_instance_config"></a> [instance\_config](#input\_instance\_config) | Configuration for the ECS instance. The 'image\_id' and 'password' attributes are required. | <pre>object({<br/>    image_id                   = string<br/>    instance_name              = optional(string, "selectdb-ecs")<br/>    instance_type              = optional(string, "ecs.g8i.4xlarge")<br/>    system_disk_category       = optional(string, "cloud_essd")<br/>    system_disk_size           = optional(number, 100)<br/>    internet_max_bandwidth_out = optional(number, 10)<br/>    password                   = string<br/>  })</pre> | n/a | yes |
| <a name="input_security_group_config"></a> [security\_group\_config](#input\_security\_group\_config) | Configuration for the security group. | <pre>object({<br/>    security_group_name = optional(string, "selectdb-sg")<br/>  })</pre> | `{}` | no |
| <a name="input_selectdb_config"></a> [selectdb\_config](#input\_selectdb\_config) | Configuration for the SelectDB instance. The 'admin\_pass' attribute is required. | <pre>object({<br/>    db_instance_description = optional(string, "SelectDB instance for real-time log analysis")<br/>    db_instance_class       = optional(string, "selectdb.4xlarge")<br/>    cache_size              = optional(number, 100)<br/>    payment_type            = optional(string, "PayAsYouGo")<br/>    engine_minor_version    = optional(string, "4.0.4")<br/>    admin_pass              = string<br/>    security_ip_group_name  = optional(string, "default")<br/>    security_ip_list        = optional(string, "192.168.0.0/16")<br/>  })</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to resources. | `map(string)` | <pre>{<br/>  "Environment": "log-analysis",<br/>  "ManagedBy": "Terraform"<br/>}</pre> | no |
| <a name="input_vpc_config"></a> [vpc\_config](#input\_vpc\_config) | Configuration for the VPC. The 'cidr\_block' attribute is required. | <pre>object({<br/>    cidr_block = string<br/>    vpc_name   = optional(string, "selectdb-vpc")<br/>  })</pre> | n/a | yes |
| <a name="input_vswitch_config"></a> [vswitch\_config](#input\_vswitch\_config) | Configuration for the VSwitch. The 'zone\_id' and 'cidr\_block' attributes are required. | <pre>object({<br/>    zone_id      = string<br/>    cidr_block   = string<br/>    vswitch_name = optional(string, "selectdb-vswitch")<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_availability_zone"></a> [availability\_zone](#output\_availability\_zone) | The availability zone of the VSwitch. |
| <a name="output_ecs_command_id"></a> [ecs\_command\_id](#output\_ecs\_command\_id) | The ID of the ECS command. |
| <a name="output_ecs_instance_id"></a> [ecs\_instance\_id](#output\_ecs\_instance\_id) | The ID of the ECS instance. |
| <a name="output_ecs_instance_name"></a> [ecs\_instance\_name](#output\_ecs\_instance\_name) | The name of the ECS instance. |
| <a name="output_ecs_invocation_id"></a> [ecs\_invocation\_id](#output\_ecs\_invocation\_id) | The ID of the ECS command invocation. |
| <a name="output_ecs_login_user"></a> [ecs\_login\_user](#output\_ecs\_login\_user) | The login username for the ECS instance. |
| <a name="output_ecs_private_ip"></a> [ecs\_private\_ip](#output\_ecs\_private\_ip) | The private IP address of the ECS instance. |
| <a name="output_ecs_public_ip"></a> [ecs\_public\_ip](#output\_ecs\_public\_ip) | The public IP address of the ECS instance. |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the security group. |
| <a name="output_selectdb_connection_string"></a> [selectdb\_connection\_string](#output\_selectdb\_connection\_string) | The VPC connection string of the SelectDB instance. |
| <a name="output_selectdb_instance_description"></a> [selectdb\_instance\_description](#output\_selectdb\_instance\_description) | The description of the SelectDB instance. |
| <a name="output_selectdb_instance_id"></a> [selectdb\_instance\_id](#output\_selectdb\_instance\_id) | The ID of the SelectDB instance. |
| <a name="output_selectdb_login_user"></a> [selectdb\_login\_user](#output\_selectdb\_login\_user) | The login username for the SelectDB instance. |
| <a name="output_selectdb_status"></a> [selectdb\_status](#output\_selectdb\_status) | The status of the SelectDB instance. |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | The CIDR block of the VPC. |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC. |
| <a name="output_vswitch_cidr_block"></a> [vswitch\_cidr\_block](#output\_vswitch\_cidr\_block) | The CIDR block of the VSwitch. |
| <a name="output_vswitch_id"></a> [vswitch\_id](#output\_vswitch\_id) | The ID of the VSwitch. |
<!-- END_TF_DOCS -->

## Submit Issues

If you have any problems when using this module, please opening
a [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) and let us know.

**Note:** There does not recommend opening an issue on this repo.

## Authors

Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com).

## License

MIT Licensed. See LICENSE for full details.

## Reference

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)