# --------------------------------------------------------------------------------
# Copyright 2020 Leap Beyond Emerging Technologies B.V.
# --------------------------------------------------------------------------------

output db_password {
  description = "root password for the aurora database"
  value       = random_password.root.result
}

output db_writer_jdbc {
  description = "writer JDBC url"
  value       = format("jdbc:mysql:aurora://%s:%d/%s", aws_rds_cluster.dbcluster.endpoint, aws_rds_cluster.dbcluster.port, var.db_name)
}

output db_reader_jdbc {
  description = "reader JDBC url"
  value       = format("jdbc:mysql:aurora://%s:%d/%s", aws_rds_cluster.dbcluster.reader_endpoint, aws_rds_cluster.dbcluster.port, var.db_name)
}
