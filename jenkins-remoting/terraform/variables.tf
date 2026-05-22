variable "aws_region" {
  description = "AWS region for the Jenkins environment"
  type        = string
  default     = "us-east-2"
}

variable "vpc_id" {
  description = "The VPC ID where Jenkins resources will be deployed"
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID for the Jenkins instances"
  type        = string
}

variable "master_instance_type" {
  description = "EC2 instance type for the Jenkins master"
  type        = string
  default     = "t3.medium"
}

variable "agent_instance_type" {
  description = "EC2 instance type for Jenkins agents"
  type        = string
  default     = "t3.small"
}

variable "agent_count" {
  description = "Number of Jenkins agent instances to create"
  type        = number
  default     = 1
}
