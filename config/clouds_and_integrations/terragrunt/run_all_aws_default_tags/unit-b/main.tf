terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

resource "aws_ssm_parameter" "unit" {
  name  = "/scalr-manual/run-all-default-tags/unit-b"
  type  = "String"
  value = "unit-b"
}
