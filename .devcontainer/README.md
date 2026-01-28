# DevContainer Configuration

This directory contains the DevContainer configuration for the Core Terraform project, enabling a consistent development environment for all contributors.

## Features

The DevContainer includes:

- **Terraform Version Management**: `tfswitch` for automatic Terraform version switching
- **AWS Tools**: AWS CLI v2 and `aws-sso-util` for AWS SSO management
- **Environment Setup**: Automatic sourcing of scripts from the `bin/` directory
- **VS Code Extensions**: Pre-configured extensions for Terraform development

## Pre-configured Environment Variables

- `AWS_ORG`: Set to `d-9067a1ef3f`

## Included Dependencies

- **tfswitch**: Terraform version switcher
- **AWS CLI v2**: Latest AWS command line interface
- **aws-sso-util**: Utility for AWS SSO configuration management
- **jq**: JSON processor for shell scripting
- **Python 3**: For running aws-sso-util and other tools

## Usage

### Opening in DevContainer

1. **VS Code with Dev Containers Extension**:
   - Open the project in VS Code
   - When prompted, click "Reopen in Container"
   - Or use Command Palette: `Dev Containers: Reopen in Container`

2. **GitHub Codespaces**:
   - The devcontainer will automatically be used when creating a Codespace

### Available Commands

Once inside the devcontainer, you'll have access to:

- `terraform.sh` wrapper script for Terraform operations
- `awssso` function for AWS SSO authentication
- `tfswitch` for Terraform version management
- All scripts from the `bin/` directory are automatically sourced

### Example Usage

```bash
# Auto load your AWS Profiles
awssso-populate-profiles

# Switch AWS profiles using SSO
awssso my-profile

# Use the terraform wrapper
./terraform.sh ops aws-sso plan

# Use tfswitch to change Terraform versions
tfswitch
```

## Automatic Setup

The devcontainer automatically:

1. Sources all `.sh` files from the `bin/` directory
2. Sets up the `AWS_ORG` environment variable
3. Configures bash completion for the terraform wrapper
4. Installs all required dependencies

## Customization

To modify the devcontainer:

- Edit `.devcontainer/devcontainer.json` for VS Code settings and extensions
- Edit `.devcontainer/Dockerfile` for additional system dependencies

## Troubleshooting

If you encounter issues:

1. **Rebuild Container**: Use Command Palette → `Dev Containers: Rebuild Container`
2. **Check Logs**: View the container build logs for any errors
3. **Verify Dependencies**: Ensure all required tools are installed by checking their versions:
   ```bash
   aws --version
   tfswitch --version
   aws-sso-util --version
