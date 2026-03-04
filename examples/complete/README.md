# Complete Example

This example demonstrates how to use the real-time log analysis with SelectDB module to create a complete infrastructure for log processing and analysis.

## Overview

This example creates:

- A VPC with a dedicated CIDR block
- A VSwitch in an available zone
- A security group for network access control
- An ECS instance for log processing
- A SelectDB instance for real-time analytics
- Automated setup scripts for the log analysis demo

## Usage

1. Clone the repository and navigate to this example:
   ```bash
   cd examples/complete
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   ```

3. Create a `terraform.tfvars` file with your configuration:
   ```hcl
   ecs_instance_password   = "YourSecurePassword123!"
   selectdb_admin_password = "YourSelectDBPassword123!"
   ```

4. Plan the deployment:
   ```bash
   terraform plan
   ```

5. Apply the configuration:
   ```bash
   terraform apply
   ```

6. After successful deployment, you can access:
   - ECS instance via SSH using the public IP and root user
   - SelectDB instance via the VPC connection string and admin user

## Configuration

### Required Variables

- `ecs_instance_password`: Password for the ECS instance root user (8-30 characters, must contain at least 3 types: uppercase, lowercase, numbers, special chars)
- `selectdb_admin_password`: Password for the SelectDB admin user (8-30 characters, must contain at least 3 types: uppercase, lowercase, numbers, special chars)

### Optional Customization

You can customize the deployment by modifying the module parameters in `main.tf`:

- VPC CIDR block and name
- VSwitch configuration
- ECS instance specifications
- SelectDB instance class and settings
- Security group configuration

## Outputs

After deployment, the following information will be available:

- VPC and VSwitch IDs
- ECS instance ID and IP addresses
- SelectDB instance ID and connection string
- Login credentials for both ECS and SelectDB

## Clean Up

To destroy the resources:

```bash
terraform destroy
```

## Notes

- The ECS instance will automatically download and install the SelectDB log analysis demo
- The setup process may take several minutes to complete
- Ensure your Alibaba Cloud account has sufficient permissions and quotas
- The SelectDB instance is configured with VPC access only for security