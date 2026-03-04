# 完整示例

[English](https://github.com/alibabacloud-automation/terraform-alicloud-real-time-log-analysis-selectdb/blob/main/examples/complete/README.md) | 简体中文

本示例演示如何使用 SelectDB 实时日志分析模块创建完整的日志处理和分析基础设施。

## 概述

本示例将创建:

- 具有专用 CIDR 块的 VPC
- 可用区中的交换机
- 用于网络访问控制的安全组
- 用于日志处理的 ECS 实例
- 用于实时分析的 SelectDB 实例
- 日志分析演示的自动化设置脚本

## 使用方法

1. 克隆仓库并导航到此示例:
   ```bash
   cd examples/complete
   ```

2. 初始化 Terraform:
   ```bash
   terraform init
   ```

3. 创建 `terraform.tfvars` 文件并填写您的配置:
   ```hcl
   ecs_instance_password   = "YourSecurePassword123!"
   selectdb_admin_password = "YourSelectDBPassword123!"
   ```

4. 规划部署:
   ```bash
   terraform plan
   ```

5. 应用配置:
   ```bash
   terraform apply
   ```

6. 部署成功后,您可以访问:
   - 使用公网 IP 和 root 用户通过 SSH 访问 ECS 实例
   - 使用 VPC 连接字符串和 admin 用户访问 SelectDB 实例

## 配置

### 必需变量

- `ecs_instance_password`: ECS 实例 root 用户的密码(8-30 个字符,必须包含至少 3 种类型:大写字母、小写字母、数字、特殊字符)
- `selectdb_admin_password`: SelectDB admin 用户的密码(8-30 个字符,必须包含至少 3 种类型:大写字母、小写字母、数字、特殊字符)

### 可选自定义

您可以通过修改 `main.tf` 中的模块参数来自定义部署:

- VPC CIDR 块和名称
- 交换机配置
- ECS 实例规格
- SelectDB 实例类型和设置
- 安全组配置

## 输出

部署后,将提供以下信息:

- VPC 和交换机 ID
- ECS 实例 ID 和 IP 地址
- SelectDB 实例 ID 和连接字符串
- ECS 和 SelectDB 的登录凭证

## 清理

销毁资源:

```bash
terraform destroy
```

## 注意事项

- ECS 实例将自动下载并安装 SelectDB 日志分析演示
- 设置过程可能需要几分钟才能完成
- 确保您的阿里云账户具有足够的权限和配额
- 为了安全,SelectDB 实例配置为仅 VPC 访问

## 成本说明

使用本示例创建的资源将产生费用,具体取决于:
- ECS 实例规格(默认: ecs.g8i.4xlarge)
- SelectDB 实例规格(默认: selectdb.4xlarge)
- 网络带宽使用
- 存储空间

请在使用前了解[阿里云定价](https://www.aliyun.com/price)。
