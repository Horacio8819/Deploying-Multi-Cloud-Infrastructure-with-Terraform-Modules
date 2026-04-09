# Deploys in eu-central-1 (default provider)
resource "aws_s3_bucket" "primary" {
  bucket = "${var.app_name}-primary-${random_id.suffix.hex}"
  provider = aws.primary
  tags = {
    Name        = "${var.app_name}-Primary-Bucket"
    Environment = var.environment
    Role        = "primary"
    ManagedBy   = "terraform"
  }
}

resource "aws_s3_bucket_versioning" "versioning_primary" {
  bucket = aws_s3_bucket.primary.id
  provider = aws.primary
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "block_primary" {
  bucket = aws_s3_bucket.primary.id
  provider = aws.primary
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}




# Deploys in eu-west-1 (aliased provider)
resource "aws_s3_bucket" "replica" {
    provider = aws.replica
    bucket   = "${var.app_name}-replica-${random_id.suffix.hex}"
    tags = {
        Name        = "${var.app_name}-Replica-Bucket"
        Environment = var.environment
        Role        = "replica"
        ManagedBy   = "terraform"
    }
}

resource "aws_s3_bucket_versioning" "versioning_replica" {
    provider = aws.replica
    bucket = aws_s3_bucket.replica.id
    versioning_configuration {
        status = "Enabled"
    }
}

resource "aws_s3_bucket_public_access_block" "block_replica" {
    provider = aws.replica
    bucket = aws_s3_bucket.replica.id

    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
}

resource "aws_s3_bucket_replication_configuration" "replication" {
  
  # Must have bucket versioning enabled first
  depends_on = [
    aws_s3_bucket_versioning.versioning_primary,
    aws_s3_bucket_versioning.versioning_replica
  ]

  role   = aws_iam_role.replication.arn
  bucket = aws_s3_bucket.primary.id

  rule {
    id     = "replicate-all"
    status = "Enabled"

    destination {
      bucket        = aws_s3_bucket.replica.arn
      storage_class = "STANDARD"
    }
  }
}


resource "random_id" "suffix" {
    byte_length = 4
}