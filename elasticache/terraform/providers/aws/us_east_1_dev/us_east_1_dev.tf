variable "access_key"   { }
variable "secret_key"   { }
variable "name"         { }
variable "region"       { }

variable "vpc_cidr"         { }
variable "azs"              { }
variable "public_subnets"   { }

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

module "network" {
  source = "../../../modules/aws/network"

  name            = "${var.name}"
  vpc_cidr        = "${var.vpc_cidr}"
  azs             = "${var.azs}"
  public_subnets  = "${var.public_subnets}"
}