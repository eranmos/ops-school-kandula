##################
#  PostgreSQL    #
##################

resource "aws_db_instance" "postgres_db" {
  identifier            = var.rds_instance_name

  engine                = var.db_engine
  engine_version        = var.db_engine_version
  instance_class        = var.bd_instance_class
  allocated_storage     = var.db_allocated_storage
  max_allocated_storage = var.db_max_allocated_storage
  storage_type          = var.db_storage_type
  storage_encrypted     = var.db_storage_encrypted

  name                  = var.db_name
  username              = var.db_username
  password              = var.db_password
  port                  = var.db_port
  iam_database_authentication_enabled = var.db_iam_authentication


  vpc_security_group_ids = [aws_security_group.postgres_db.id]
  db_subnet_group_name   = aws_db_subnet_group.postgres_db.id
  parameter_group_name   =  var.db_parameter_group_name
  option_group_name      = var.db_option_group_name

  availability_zone   = var.db_availability_zone
  multi_az            = var.db_multi_az
  publicly_accessible = var.db_publicly_accessible
#  ca_cert_identifier  = var.ca_cert_identifier

  allow_major_version_upgrade = var.allow_major_version_upgrade
  auto_minor_version_upgrade  = var.auto_minor_version_upgrade
  apply_immediately           = var.apply_immediately
  maintenance_window          = var.db_maintenance_window

  backup_retention_period   = var.backup_retention_period
   backup_window             = var.db_backup_window
  skip_final_snapshot       = true
  final_snapshot_identifier = false

  deletion_protection      = var.deletion_protection
  delete_automated_backups = var.delete_automated_backups

  tags = local.common_tags

}

resource "aws_db_subnet_group" "postgres_db" {
  name       = "postgres_db_subnets"
  subnet_ids = ["${data.aws_subnet.public-us-east-1a.id}", "${data.aws_subnet.public-us-east-1b.id}"]

  tags = local.common_tags
}
