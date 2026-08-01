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

variable "jenkins_controller_cidr" {
  description = "Public IP (CIDR /32) of the Jenkins controller instance, allowed to SSH into the agent"
  type        = string
}
