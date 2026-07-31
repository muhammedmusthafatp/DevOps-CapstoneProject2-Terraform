variable "project_name" {
  description = "Name prefix for all resources"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "m7i-flex.large"
}

variable "key_name" {
  description = "Name of the existing EC2 key pair for SSH access"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet ID for the Jenkins agent instance"
  type        = string
}

variable "private_subnet_id" {
  description = "Private subnet ID for the app instance"
  type        = string
}

variable "jenkins_sg_id" {
  description = "Security group ID for the Jenkins agent instance"
  type        = string
}

variable "app_sg_id" {
  description = "Security group ID for the app instance"
  type        = string
}

variable "instance_profile_name" {
  description = "IAM instance profile name to attach to instances"
  type        = string
}
