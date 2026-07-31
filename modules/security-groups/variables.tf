variable "project_name" {
  description = "Name prefix for all resources"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID to create security groups in"
  type        = string
}

variable "admin_cidr" {
  description = "Your IP address (CIDR /32) allowed to SSH and access Jenkins UI"
  type        = string
}
