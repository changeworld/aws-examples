#--------------------------------------------------------------
# This module creates all compute resources
#--------------------------------------------------------------

variable "name"               { }
variable "vpc_id"             { }
variable "public_subnet_ids"  { }

module "elasticache" {
  source = "./elasticache"

  name               = "${var.name}-elasticache"
  vpc_id             = "${var.vpc_id}"
  subnet_ids         = "${var.public_subnet_ids}"
}