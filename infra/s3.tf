resource "aws_s3_bucket" "my_bucket" {
    bucket = "${var.project_name}-storage894031"
}
resource "aws_s3_bucket_public_access_block" "public_access_block" {
    bucket = aws_s3_bucket.my_bucket.id

    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "versioning" {
    bucket = aws_s3_bucket.my_bucket.id
    versioning_configuration {
        status = "enabled"
    }
}

resource "aws_s3_bucket_lifecycyle_policy" "bucket_policy" {
    bucket = "${var.project_name}-bucket-policy"

    rule {
        id = "intelligent-tiering"
        status = "Enabled"
    }
   transition {
        days = 0
        storage_class = "INTELLIGENT_TIERING"
    }
    noncurrent_version_expiration {
        days = 30
        storage_class = "GLACIER_INSTANT"
    }
}

resource "aws_server_side_encryption" "at_rest_encryption" {
    bucket = aws_s3_bucket.my_bucket.id
    rule {
        apply_server_side_encryption_by_default {
            sse_algorithm = "AES-256"
        }
    }
}