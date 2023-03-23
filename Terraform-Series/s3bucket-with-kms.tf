resource "aws_kms_key" "kskey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

resource "aws_s3_bucket" "bootcamp30-2-koyin" {
  bucket = "bootcamp30-2-koyin"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sseconfig" {
  bucket = aws_s3_bucket.bootcamp30-2-koyin.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.kskey.arn
      sse_algorithm     = "aws:kms"
    }
  }
}