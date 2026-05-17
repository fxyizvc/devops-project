# Automated Cloud Deployment Pipeline

**Author:** Muhammed Fayiz V C  
**Role:** DevOps / Cloud Engineering Portfolio Project

## Project Overview
This project demonstrates a complete, automated Continuous Integration and Continuous Deployment (CI/CD) pipeline. It provisions cloud infrastructure from scratch using Infrastructure as Code (IaC) and automatically deploys a containerized web application to an AWS EC2 instance upon every code commit.

## Tech Stack & Tools Used
* **Local Environment:** Linux (Ubuntu via VMware)
* **Version Control:** Git & GitHub
* **Containerization:** Docker
* **Cloud Provider:** Amazon Web Services (AWS)
* **Infrastructure as Code (IaC):** Terraform
* **CI/CD Automation:** GitHub Actions

## Architecture Flow
1. **Source Code Management:** Code is developed locally and pushed to the `main` branch on GitHub.
2. **Infrastructure Provisioning:** Terraform is used to automatically provision an AWS `t3.micro` EC2 instance, configure an AWS Security Group (opening Ports 22 and 80), and bootstrap the server with Docker via a `user_data` script.
3. **Automated Pipeline:** GitHub Actions detects the push, securely SSHs into the EC2 instance using stored GitHub Secrets, pulls the latest code, builds a new Docker image, and spins up the container.

## Key Learnings & Challenges Overcome
* Transitioned from manual AWS Console deployments to fully automated Terraform IaC.
* Managed large binary file tracking issues by implementing `.gitignore` for Terraform plugins and state files.
* Secured cloud infrastructure by keeping private `.pem` keys out of version control and strictly utilizing GitHub Secrets.
* Resolved Security Group firewall timeouts to allow GitHub Actions seamless SSH access to the AWS environment.

## How to Deploy (For Reviewers)
1. Ensure AWS CLI is configured with the necessary IAM access.
2. Run `terraform init`, `terraform plan`, and `terraform apply` to provision the EC2 instance and Security Group.
3. Add the resulting Public IPv4 address to GitHub Secrets as `EC2_HOST`.
4. Push code changes to the `main` branch to trigger the GitHub Actions workflow.
5. Access the live site via the EC2 Public IP on Port 80.
6. Run `terraform destroy` to tear down all infrastructure and prevent billing.
