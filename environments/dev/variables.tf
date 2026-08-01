variable "aws_region" {
  description = "AWS region to deploy infrastructure"
  type        = string
  default     = "ap-south-2"
}

variable "project_name" {
  description = "Project name used as a prefix/tag for all resources"
  type        = string
  default     = "capstone2"
}
variable "admin_cidr" {
  description = "Your IP in CIDR form, for SSH/Jenkins UI access"
  type        = string
}
variable "key_name" {
  description = "Name of the existing EC2 key pair for SSH access"
  type        = string
}
variable "jenkins_controller_cidr" {
  description = "Public IP (CIDR /32) of the Jenkins controller instance"
  type        = string
}
