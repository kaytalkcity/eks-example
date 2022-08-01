terraform {
  required_version = ">= 0.13.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.1"
    }

    grafana = {
    source  = "grafana/grafana"
    version = "1.24.0"
    }

  }

}
