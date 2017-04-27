#--------------------------------------------------------------
# This module creates all networking resources
#--------------------------------------------------------------

variable "name"     { }
variable "vpc_cidr" { }

module "vpc" {
  source = "./vpc"

  name = "${var.name}-vpc"
  cidr = "${var.vpc_cidr}"
}

# VPC
output "vpc_id"   { value = "${module.vpc.vpc_id}" }
output "vpc_cidr" { value = "${module.vpc.vpc_cidr}" }