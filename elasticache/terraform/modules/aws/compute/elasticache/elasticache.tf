#--------------------------------------------------------------
# This module creates all resources necessary for ElastiCache
#--------------------------------------------------------------

variable "name"       { default = "elasticache" }
variable "vpc_id"     { }
variable "subnet_ids" { }
variable "azs"        { }

variable "number_cache_clusters"  { }
variable "node_type"              { }
variable "engine_version"         { }
variable "parameter_group_name"   { }

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

resource "aws_elasticache_replication_group" "elasticache" {
  replication_group_id          = "${var.name}"
  replication_group_description = "ElastiCache replication group"
  number_cache_clusters         = "${var.number_cache_clusters}"
  node_type                     = "${var.node_type}"
  automatic_failover_enabled    = true
  availability_zones            = ["${split(",", var.azs)}"]
  engine_version                = "${var.engine_version}"
  parameter_group_name          = "${var.parameter_group_name}"
  port                          = 6379
  subnet_group_name             = "${aws_elasticache_subnet_group.elasticache.name}"
  security_group_ids            = ["${aws_security_group.elasticache.id}"]
  maintenance_window            = "sun:05:00-sun:09:00"
}