terraform {
  required_version = ">= 1.0"

  backend "pg" {
    conn_str = "postgres://tf_user:tf_password@localhost:5432/terraform_backend?sslmode=disable"
    schema_name = "terraform_remote_state"
  }
}
