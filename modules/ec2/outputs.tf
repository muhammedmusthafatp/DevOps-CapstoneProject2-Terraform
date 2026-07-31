output "jenkins_agent_public_ip" {
  value = aws_instance.jenkins_agent.public_ip
}

output "jenkins_agent_id" {
  value = aws_instance.jenkins_agent.id
}

output "app_instance_private_ip" {
  value = aws_instance.app.private_ip
}

output "app_instance_id" {
  value = aws_instance.app.id
}
