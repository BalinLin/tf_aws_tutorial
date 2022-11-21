terraform {
  #####
  # A configuration can only provide one backend block.
  # A backend block cannot refer to named values (like input variables, locals, or data source attributes).
  # Warning: We recommend using environment variables to supply credentials and other sensitive data.
  # If you use -backend-config or hardcode these values directly in your configuration,
  # Terraform will include these values in both the .terraform subdirectory and in plan files.
  # This can leak sensitive credentials.
  #####

  backend "s3" {}

  #####
  # Use Terraform cloud to save state
  # You do not need to configure a backend when using Terraform Cloud because
  # Terraform Cloud automatically manages state in the workspaces associated with your configuration.
  # If your configuration includes a "cloud block", it cannot include a backend block.
  #####

#   cloud {
#     organization = "organization-name"
#     workspaces {
#       name = "learn-tfc-aws"
#     }
#   }

  required_providers {
    aws = {
      source  = "hashicorp/aws" # registry.terraform.io/hashicorp/aws
      version = "~> 4.16"       # Optional
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  # region  = "us-west-2"
  region = "ap-northeast-1"
}

resource "aws_instance" "app_server" {             # the resource type (aws_) and the resource name, id is "aws_instance.app_server"
  ami                    = "ami-072bfb8ae2c884cc4" # region-specific
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-0edab03645f5889c8"]
  subnet_id              = "subnet-0111676a1cfbd19d8"
  tags = {
    Name = var.instance_name # instance name
  }
}
