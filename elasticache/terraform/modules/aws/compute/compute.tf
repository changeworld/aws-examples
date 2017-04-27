#--------------------------------------------------------------
# This module creates all compute resources
#--------------------------------------------------------------

variable "name"               { }
variable "vpc_id"             { }

module "elasticache" {
  source = "./elasticache"

  name               = "${var.name}-elasticache"
  vpc_id             = "${var.vpc_id}"
}