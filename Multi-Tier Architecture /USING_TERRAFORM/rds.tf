resource "aws_db_subnet_group" "db_subnet" {
  name = "prod-db-subnet-group"

  subnet_ids = [
    aws_subnet.private_db_1.id,
    aws_subnet.private_db_2.id
  ]
}

resource "aws_db_instance" "postgres" {
  identifier             = "prod-postgres"
  engine                 = "postgres"
  engine_version         = "15"
  instance_class         = "db.t3.micro"

  allocated_storage      = 20
  storage_type           = "gp3"

  username               = var.db_username
  manage_master_user_password = true

  publicly_accessible    = false
  storage_encrypted      = true

  backup_retention_period = 0

  multi_az               = false

  db_subnet_group_name = aws_db_subnet_group.db_subnet.name

  vpc_security_group_ids = [
    aws_security_group.db_sg.id
  ]

  skip_final_snapshot = true
}