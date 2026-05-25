resource "aws_elasticache_subnet_group" "redis_subnet" {
  name = "prod-redis-subnet"

  subnet_ids = [
    aws_subnet.private_cache_1.id,
    aws_subnet.private_cache_2.id
  ]
}

resource "aws_elasticache_replication_group" "redis" {
  replication_group_id       = "prod-redis"
  description                = "Production Redis"
  node_type                  = "cache.t3.micro"
  engine                     = "redis"
  engine_version             = "7.0"
  automatic_failover_enabled = true
  multi_az_enabled           = true
  num_cache_clusters         = 2

  subnet_group_name = aws_elasticache_subnet_group.redis_subnet.name

  security_group_ids = [aws_security_group.redis_sg.id]

  at_rest_encryption_enabled = true
  transit_encryption_enabled = true
}