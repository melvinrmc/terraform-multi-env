terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

module "development" {
  source = "./aws-stack"
  environment = "development"
  additional_tags = {
    environment = "development"
  }
  queue_lambda_triggered_arn = "arn:aws:lambda:us-east-1:646101853261:function:memberReplicationProc-dev"
}

module "mariadb" {
  source = "./mariadb"
}

output "members_queue_id" {
  value = module.development.members_queue_id
}
