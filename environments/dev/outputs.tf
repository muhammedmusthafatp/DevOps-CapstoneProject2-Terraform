output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "nat_gateway_id" {
  value = module.vpc.nat_gateway_id
}
output "jenkins_agent_public_ip" {
  value = module.ec2.jenkins_agent_public_ip
}

output "app_instance_private_ip" {
  value = module.ec2.app_instance_private_ip
}
