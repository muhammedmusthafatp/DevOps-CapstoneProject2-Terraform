terraform {
  backend "s3" {
    bucket         = "s3bucket-terraforms"
    key            = "infrastructure/terraform.tfstate"
    region         = "ap-south-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
