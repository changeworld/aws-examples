variable "access_key"   { }
variable "secret_key"   { }
variable "name"         { }
variable "region"       { }

variable "vpc_cidr"         { }
variable "azs"              { }
variable "public_subnets"   { }

variable "elasticache_cluster_count"    { }
variable "elasticache_instance_type"    { }
variable "elasticache_engine_version"   { }
variable "elasticache_parameter_group"  { }

provider "aws" {
  access_key  = "${var.access_key}"
  secret_key  = "${var.secret_key}"
  region      = "${var.region}"
}

module "network" {
  source = "../../../modules/aws/network"

  name            = "${var.name}"
  vpc_cidr        = "${var.vpc_cidr}"
  azs             = "${var.azs}"
  public_subnets  = "${var.public_subnets}"
}

module "compute" {
  source = "../../../modules/aws/compute"

  name                        = "${var.name}"
  vpc_id                      = "${module.network.vpc_id}"
  public_subnet_ids           = "${module.network.public_subnet_ids}"
  azs                         = "${var.azs}"
  elasticache_cluster_count   = "${var.elasticache_cluster_count}"
  elasticache_instance_type   = "${var.elasticache_instance_type}"
  elasticache_engine_version  = "${var.elasticache_engine_version}"
  elasticache_parameter_group = "${var.elasticache_parameter_group}"
}