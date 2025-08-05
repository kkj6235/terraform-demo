terraform {
 backend "s3" {
   bucket = "cjwave-kkj"
   key = "stage/data-stores/mysql/terraform.tfstate"
   region = "ap-northeast-2"
   dynamodb_table = "terraform-locks"
   encrypt = true
 }
}


provider "aws" {
 region = "ap-northeast-2"
}
variable "db_username" {
  default = "kkj"
}
variable "db_password" {
  default = "testpass"
}
resource "aws_db_instance" "example" {
    identifier_prefix = "terraform-mysql"
    engine = "mysql"
    allocated_storage = 10
    instance_class = "db.t3.micro"
    skip_final_snapshot = true
    db_name = "example_database"
    # How should we set the username and password?
    username = var.db_username
    password = var.db_password
}
output "address" {
    value = aws_db_instance.example.address
    description = "Connect to the database at this endpoint"
}
output "port" {
    value = aws_db_instance.example.port
    description = "The port the database is listening on"
}