# DevContainer Scripts

⚠️ **Note:** These scripts are intended for use within the devcontainer environment only.

## Scripts

- **`awssso.sh`** - AWS SSO authentication helper functions
  - `awssso <profile>` - Login to AWS SSO with the specified profile
  - `awssso-logout` - Logout from current AWS SSO session
  - `awssso-refresh` - Refresh current AWS SSO session
  - `awssso-get-credentials` - Get AWS credentials for current session
  - `awssso-get-token` - Get AWS SSO access token
  - `awssso-export` - Export AWS credentials as environment variables
  - `awssso-unset` - Unset AWS credential environment variables
  - `awssso-populate-profiles` - Populate AWS profiles from SSO

- **`terraform.sh`** - Terraform wrapper script with bash completion
  - `t` - Alias for executing terraform.sh wrapper in current directory
  - Provides tab completion for workspace directories

## How It Works

These scripts are automatically sourced when the devcontainer starts via the [`Dockerfile`](../Dockerfile):

1. The Dockerfile creates a helper script at `/usr/local/bin/source-bin-files.sh`
2. This helper script sources all `.sh` files in this directory
3. The helper is called from `/home/vscode/.bashrc` on shell startup

This ensures all functions and aliases are available in every terminal session within the devcontainer.
