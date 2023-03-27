resource "aws_kms_key" "kskey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}


resource "random_id" "id" {
    byte_length = 8
}

variable "myname" {
    type = string
    default = "koyin"
}

resource "aws_s3_bucket" "bootcamp30-RN-koyin" {
  bucket = "bootcamp30-${random_id.id.hex}-${var.myname}"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sseconfig" {
  bucket = aws_s3_bucket.bootcamp30-RN-koyin.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.kskey.arn
      sse_algorithm     = "aws:kms"
    }
  }
}