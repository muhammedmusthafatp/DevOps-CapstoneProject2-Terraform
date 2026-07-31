variable "aws_region" {
  description = "AWS region to deploy backend resources"
  type        = string
  default     = "ap-south-2"
}

variable "state_bucket_name" {
  description = "Globally unique S3 bucket name for Terraform state"
  type        = string
}

variable "lock_table_name" {
  description = "DynamoDB table name for state locking"
  type        = string
  default     = "terraform-locks"
}
