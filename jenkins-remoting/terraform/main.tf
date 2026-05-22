terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Fetch latest Ubuntu 22.04 AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Jenkins Master EC2 Instance
resource "aws_instance" "jenkins_master" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.master_instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.jenkins.id]
  key_name                    = "codealpha-jenkins-key"
  associate_public_ip_address = true


  user_data = file("${path.module}/user-data/jenkins-master.sh")

  tags = {
    Name = "jenkins-master"
  }
}

# Jenkins Agent EC2 Instances
resource "aws_instance" "jenkins_agent" {
  count                       = var.agent_count
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.agent_instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.jenkins.id]
  key_name                    = "codealpha-jenkins-key"
  associate_public_ip_address = true

  user_data = file("${path.module}/user-data/jenkins-agent.sh")

  tags = {
    Name = "jenkins-agent-${count.index + 1}"
  }
}
