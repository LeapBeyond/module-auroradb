# --------------------------------------------------------------------------------
# Copyright 2020 Leap Beyond Emerging Technologies B.V.
# --------------------------------------------------------------------------------

terraform {
  required_version = ">= 0.13"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=3.6.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">=3.0.0"
    }
  }
}
