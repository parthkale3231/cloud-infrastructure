resource "aws_s3_bucket" "storage" {
  bucket = "prod-storage-bucket-demo-12345"
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.storage.id

  versioning_configuration {
    status = "Enabled"
  }
}