provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "public_bucket" {
  bucket = "mi-bucket-publico"
  acl    = "public-read"  # Establece permisos de lectura pública en el bucket

  website {
    index_document = "index.html"
  }
}

# Política para permitir acceso público a los objetos dentro del bucket
resource "aws_s3_bucket_policy" "public_access_policy" {
  bucket = aws_s3_bucket.public_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.public_bucket.arn}/*"
      }
    ]
  })
} 
