module "shared-module-1" {
  source = "../../../modules/shared-module-1"

  # Use variables in 'shared-module' for environment specific configuration
  env = "dev"
}
