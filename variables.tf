# --------------------------------------------------------------------------------
# Copyright 2020 Leap Beyond Emerging Technologies B.V.
# --------------------------------------------------------------------------------
variable vpc_id {
  type        = string
  description = "ID of the VPC to install into - required"
}

variable subnet_id {
  type        = list(string)
  description = "list of Subnet IDs in the VPC into which the cluster can be installed - required"
}

variable access_ip {
  type        = list(string)
  description = "list of CIDR blocks allowed to access the database - this default is not recommended"
  default     = ["0.0.0.0/0"]
}

variable tags {
  type        = map(string)
  description = "base set of tags to apply to assets"
  default = {
    "Owner"   = "Leap Beyond"
    "Project" = "dbtest"
    "Client"  = "internal"
  }
}

variable basename {
  type       = string
  decription = "prefix used for various names - required"
}

variable db_name {
  type        = string
  description = "name of the initial database to create - required"
}

variable cluster_size {
  type        = number
  description = "number of instances in the cluster"
  default     = 2
}
