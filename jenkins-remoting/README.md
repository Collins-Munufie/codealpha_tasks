# CodeAlpha_JenkinsRemoting

This project provisions a scalable Jenkins Master and Agent architecture on AWS using Terraform. It demonstrates Jenkins Distributed Builds (Remoting), allowing you to execute build jobs on dedicated agent nodes instead of the master, ensuring better performance, scalability, and isolation.

## Project Structure

```text
CodeAlpha_JenkinsRemoting/
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── security-groups.tf
│   ├── user-data/
│   │   ├── jenkins-master.sh
│   │   └── jenkins-agent.sh
├── jenkins/
│   ├── Jenkinsfile
│   └── plugins.txt
└── README.md
```

## Features

- **Infrastructure as Code**: Terraform configuration for provisioning AWS EC2 instances for both the Jenkins Master and Agents.
- **Bootstrapping**: Shell scripts in the `user-data` directory automatically install dependencies (like Java 17) and prepare the instances upon boot.
- **Jenkins Pipeline**: A sample declarative `Jenkinsfile` ready to execute continuous integration tasks specifically on the remote agents.
- **Jenkins Plugins**: A `plugins.txt` file listing the essential Jenkins plugins (e.g., git, pipeline, ssh-slaves) required for remote management and typical CI/CD workflows.

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) installed locally (>= 1.3.0).
- AWS CLI installed, configured with valid credentials, and having appropriate permissions to create EC2 instances, VPC components, and Security Groups.
- An existing AWS Subnet and SSH Key Pair in your specified region.

## Setup Instructions

### 1. Provision Infrastructure

Navigate to the `terraform/` directory:
```bash
cd terraform
```

Initialize the Terraform working directory:
```bash
terraform init
```

Review the deployment plan to see what resources will be created:
```bash
terraform plan
```

Apply the Terraform configuration to provision the AWS infrastructure:
```bash
terraform apply
```

### 2. Configure Jenkins

1. Once the instances are fully provisioned, obtain the public IP address of the Jenkins Master from the output provided by Terraform.
2. Access the Jenkins web dashboard via `http://<MASTER_PUBLIC_IP>:8080`.
3. Complete the initial Jenkins setup. The administrator password can typically be found on the master node by connecting via SSH and reading `/var/lib/jenkins/secrets/initialAdminPassword` (depending on the master bootstrap script).
4. Install the required plugins defined in `jenkins/plugins.txt`.
5. Add the provisioned agent node(s) in Jenkins:
   - Go to **Manage Jenkins** -> **Nodes** -> **New Node**.
   - Select **Permanent Agent**.
   - Configure the agent with the IP provided by the Terraform outputs and use SSH (via the `ssh-slaves` plugin) to establish the Jenkins remoting connection.

### 3. Run Pipeline

Create a new Pipeline job in Jenkins and point it to the provided `jenkins/Jenkinsfile` in this repository. The pipeline is explicitly configured to execute its stages directly on the remote agents (`agent { label 'aws-agent' }`).

## Cleanup

To destroy the provisioned AWS resources and avoid incurring any unwanted charges, run the following command in the `terraform/` directory:
```bash
terraform destroy
```
