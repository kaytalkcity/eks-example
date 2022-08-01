provider "aws" {
  region = local.region
}


provider "grafana" {
  url  = try(var.grafana_endpoint, "https://${module.managed_grafana.workspace_endpoint}")
  auth = var.grafana_api_key
}

locals {
  name   = basename(path.cwd)
  region = "us-east-1"


  tags = {
    Blueprint  = local.name
    env = "eks-shared"
  }
}

#---------------------------------------------------------------
# Observability Resources
#---------------------------------------------------------------

module "managed_grafana" {
  source  = "terraform-aws-modules/managed-service-grafana/aws"
  version = "~> 1.3"

  # Workspace
  name              = local.name
  stack_set_name    = local.name
  data_sources      = ["PROMETHEUS"]
  associate_license = false

  tags = local.tags
}


module "managed_prometheus" {
  source  = "terraform-aws-modules/managed-service-prometheus/aws"
  version = "~> 2.1"

  workspace_alias = local.name
}
