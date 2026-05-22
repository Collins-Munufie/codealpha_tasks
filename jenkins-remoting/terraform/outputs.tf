output "jenkins_master_instance_id" {
  description = "ID of the Jenkins master EC2 instance"
  value       = aws_instance.jenkins_master.id
}

output "jenkins_master_public_ip" {
  value = aws_instance.jenkins_master.public_ip
}

output "jenkins_master_url" {
  value = "http://${aws_instance.jenkins_master.public_ip}:8080"
}

output "jenkins_agent_instance_ids" {
  description = "IDs of the Jenkins agent EC2 instances"
  value       = aws_instance.jenkins_agent[*].id
}

output "jenkins_security_group_id" {
  description = "ID of the Jenkins security group"
  value       = aws_security_group.jenkins.id
}



