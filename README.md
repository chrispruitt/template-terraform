# Core Terraform

This repo manages organization level resources.

## Quick Start

**Run in DevContainer (Recommended):**
1. Install [VS Code](https://code.visualstudio.com/) and the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
2. Clone this repository and open it in VS Code
3. Click "Reopen in Container" when prompted (or press `F1` → "Dev Containers: Reopen in Container")
4. All tools and scripts are automatically configured and ready to use

See [`.devcontainer/README.md`](.devcontainer/README.md) for detailed DevContainer documentation.

## Repo Structure

This repo subscribes to the GitOps directory structure where the `main` branch is the single source of truth.

**File structure:**

The `modules` directory contains shared modules between environments.

The `workspaces` directory contains the root terraform modules which implement a module for the specific environment. Difference between environments are managed here.

- `modules/`
  - shared-module-1
  - shared-module-2
- `workspaces/`
  - dev/
    - root-module-1
    - root-module-2
  - qa/
  - uat/
  - prod/
  - ops/


## Contributing

### Option 1: DevContainer (Recommended)

Use the provided DevContainer for a consistent development environment with all dependencies pre-installed:

1. Open the project in VS Code or Intellij with the Dev Containers extension
2. When prompted, click "Reopen in Container"
3. All required tools (tfswitch, AWS CLI, aws-sso-util) will be automatically available

See [`.devcontainer/README.md`](.devcontainer/README.md) for detailed DevContainer documentation.

```bash
# Auto load your AWS Profiles - your AWS config will persist between devcontainer rebuilds
awssso-populate-profiles

# Switch AWS profiles using SSO with auto completion
awssso my-profile

# Use the terraform wrapper via the 't' command with auto completion
t ops aws-sso plan
```

### Option 2: Local Development

**Prereqs:**

- Install [tfswitch](https://github.com/warrensbox/terraform-switcher)
- Install [AWS CLI v2](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- Install [aws-sso-util](https://github.com/benkehoe/aws-sso-util): `pip install aws-sso-util`

**Execute terraform commands**

```bash
./terraform.sh <env> <module> <terraform command>

# Example
./terraform.sh ops aws-sso plan
```

**Terraform Wrapper**

Use the `terraform.sh` wrapper script to execute terraform commands against this project.

This wrapper will handle:

- terraform version managment (via tfswitch)
- terraform workspace selection
