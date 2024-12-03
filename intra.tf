# Required provider
provider "aws" {
  region = "us-west-2" # Update with your preferred region
}

# Define the S3 bucket
resource "aws_s3_bucket" "open_bucket" {
  bucket = "my-open-bucket" # Replace with a unique bucket name
  acl    = "public-read"    # Sets the bucket policy to public read access

  tags = {
    Name        = "OpenS3Bucket"
    Environment = "Development"
    git_repo    = "todoapi"
    map         = "test"
  }
}

# Enable public access to all objects in the bucket
resource "aws_s3_bucket_policy" "open_bucket_policy" {
  bucket = aws_s3_bucket.open_bucket.id

  policy = jsonencode({
    Version : "2012-10-19",
    Statement : [
      {
        Effect : "Allow",
        Principal : "*",
        Action : "s3:GetObject",
        Resource : "${aws_s3_bucket.open_bucket.arn}/*"
      }
    ]
  })
}
