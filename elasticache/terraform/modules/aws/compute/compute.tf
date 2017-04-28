#--------------------------------------------------------------
# This module creates all compute resources
#--------------------------------------------------------------

variable "name"                         { }
variable "vpc_id"                       { }
variable "public_subnet_ids"            { }
variable "azs"                          { }
variable "elasticache_cluster_count"    { }
variable "elasticache_instance_type"    { }
variable "elasticache_engine_version"   { }
variable "elasticache_parameter_group"  { }

module "elasticache" {
  source = "./elasticache"

  name                  = "${var.name}"
  vpc_id                = "${var.vpc_id}"
  subnet_ids            = "${var.public_subnet_ids}"
  azs                   = "${var.azs}"
  number_cache_clusters = "${var.elasticache_cluster_count}"
  node_type             = "${var.elasticache_instance_type}"
  engine_version        = "${var.elasticache_engine_version}"
  parameter_group_name  = "${var.elasticache_parameter_group}"
}