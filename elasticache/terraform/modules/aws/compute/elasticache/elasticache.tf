#--------------------------------------------------------------
# This module creates all resources necessary for ElastiCache
#--------------------------------------------------------------

variable "name"         { default = "elasticache" }
variable "vpc_id"       { }
variable "subnet_ids"   { }

resource "aws_security_group" "elasticache" {
  name        = "${var.name}"
  vpc_id      = "${var.vpc_id}"
  description = "ElastiCache security group"

  tags      { 
    Name = "${var.name}" 
    Demo = "true"
  }
  lifecycle { create_before_destroy = true }

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 6379
    to_port     = 6379
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    self        = true
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_elasticache_subnet_group" "elasticache" {
  name        = "${var.name}"
  description = "ElastiCache subnet group"
  subnet_ids  = ["${split(",", var.subnet_ids)}"]
}