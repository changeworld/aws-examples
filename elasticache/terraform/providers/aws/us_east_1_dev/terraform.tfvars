#--------------------------------------------------------------
# General
#--------------------------------------------------------------

# When using the GitHub integration, variables are not updated
# when checked into the repository, only when you update them
# via the web interface. When making variable changes, you should
# still check them into GitHub, but don't forget to update them
# in the web UI of the appropriate environment as well.

# If you change the atlas_environment name, be sure this name
# change is reflected when doing `terraform remote config` and
# `terraform push` commands - changing this WILL affect your
# terraform.tfstate file, so use caution

name    = "elasticache-dev"
region  = "us-east-1"

#--------------------------------------------------------------
# Network
#--------------------------------------------------------------

vpc_cidr        = "192.168.0.0/16"
azs             = "us-east-1a,us-east-1c" # AZs are region specific
public_subnets  = "192.168.11.0/24,192.168.12.0/24" # Creating one public subnet per AZ

#--------------------------------------------------------------
# Data
#--------------------------------------------------------------

#--------------------------------------------------------------
# Compute
#--------------------------------------------------------------

elasticache_cluster_count   = "2"
elasticache_instance_type   = "cache.t2.micro"
elasticache_engine_version  = "3.2.4"
elasticache_parameter_group = "default.redis3.2.cluster.on"