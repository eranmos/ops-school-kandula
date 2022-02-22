##########
# OUTPUT
##########

# DB PostgreSQL Info
output "db_instance_address" {
  description = "The address of the RDS instance"
  value       = aws_db_instance.postgres_db.address
}

output "db_instance_endpoint" {
  description = "The connection endpoint"
  value       = aws_db_instance.postgres_db.endpoint
}

output "db_instance_hosted_zone_id" {
  description = "The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record)"
  value       = aws_db_instance.postgres_db.hosted_zone_id
}

output "db_instance_id" {
  description = "The RDS instance ID"
  value       = aws_db_instance.postgres_db.id
}

output "db_instance_status" {
  description = "The RDS instance status"
  value       = aws_db_instance.postgres_db.status
}

output "db_instance_name" {
  description = "The database name"
  value       = aws_db_instance.postgres_db.name
}

output "db_instance_username" {
  description = "The master username for the database"
  value       = aws_db_instance.postgres_db.username
  sensitive   = true
}

output "db_instance_master_password" {
  description = "The master password"
  value       = aws_db_instance.postgres_db.password
  sensitive   = true
}

output "db_instance_port" {
  description = "The database port"
  value       = aws_db_instance.postgres_db.port
}
