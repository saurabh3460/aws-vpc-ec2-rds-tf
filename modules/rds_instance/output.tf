output "db_pasword" {
    value = random_string.random_rds_password.result
}