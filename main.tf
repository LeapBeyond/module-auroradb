# --------------------------------------------------------------------------------
# Copyright 2020 Leap Beyond Emerging Technologies B.V.
# --------------------------------------------------------------------------------

# -----------------------------------------------------------
# password for the admin user
# -----------------------------------------------------------
resource random_password root {
  length      = 16
  special     = false
  min_numeric = 3
  min_upper   = 2
  min_lower   = 2
}

# -----------------------------------------------------------
# security group for the cluster members
# -----------------------------------------------------------
resource aws_security_group mysql_access {
  name        = "mysql_access"
  description = "allows mysql access"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = var.access_ip
  }

  egress {
    from_port   = 1024
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = var.access_ip
  }

  tags = merge({ "Name" = "${var.basename}-mysql-access" }, var.tags)
}

# -----------------------------------------------------------
# cluster definition
# -----------------------------------------------------------
resource aws_db_subnet_group dbcluster {
  name       = var.vpc_name
  subnet_ids = var.subnet_id
  tags       = merge({ "Name" = "${var.basename}-dbcluster" }, var.tags)
}

resource aws_rds_cluster dbcluster {
  timeouts {
    create = "10m"
    update = "10m"
    delete = "10m"
  }

  cluster_identifier                  = var.basename
  copy_tags_to_snapshot               = true
  database_name                       = var.db_name
  db_cluster_parameter_group_name     = "default.aurora5.6"
  db_subnet_group_name                = aws_db_subnet_group.dbcluster.name
  enable_http_endpoint                = false
  engine                              = "aurora"
  engine_mode                         = "provisioned"
  engine_version                      = "5.6.10a"
  iam_database_authentication_enabled = false
  master_username                     = "admin"
  master_password                     = random_password.root.result
  port                                = 3306
  skip_final_snapshot                 = true
  storage_encrypted                   = true
  vpc_security_group_ids              = [aws_security_group.mysql_access.id]

  tags = merge({ "Name" = "${var.basename}-dbcluster" }, var.tags)
}

# -----------------------------------------------------------
# cluster instance definition
# -----------------------------------------------------------
resource aws_rds_cluster_instance dbcluster_instance {
  count = var.cluster_size

  timeouts {
    create = "10m"
    update = "10m"
    delete = "10m"
  }

  identifier_prefix            = var.basename
  cluster_identifier           = aws_rds_cluster.dbcluster.cluster_identifier
  engine                       = "aurora"
  engine_version               = "5.6.10a"
  instance_class               = "db.r5.large"
  publicly_accessible          = true
  db_subnet_group_name         = aws_db_subnet_group.dbcluster.name
  db_parameter_group_name      = "default.aurora5.6"
  promotion_tier               = 1
  performance_insights_enabled = false
  copy_tags_to_snapshot        = true

  tags = merge({ "Name" = "${var.basename}-dbcluster-instance" }, var.tags)
}
