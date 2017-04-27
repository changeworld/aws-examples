variable "access_key"   { }
variable "secret_key"   { }
variable "name"         { }
variable "region"       { }

variable "vpc_cidr" { }

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

module "network" {
  source = "../../../modules/aws/network"

  name            = "${var.name}"
  vpc_cidr        = "${var.vpc_cidr}"
}