# 🚀 Task-3: EC2 Provisioning & Strapi Deployment using Terraform

## 📌 Overview

In this task, an AWS EC2 instance was provisioned using Terraform with a proper module structure.  
A secure RSA private key (.pem) was generated using the TLS provider and managed by Terraform.  
After infrastructure provisioning, a Strapi application was deployed and successfully accessed via the EC2 public IP.

---

## 🛠️ Technologies Used

- AWS EC2
- Terraform
- Terraform Modules
- TLS Provider
- Node.js (v20)
- Strapi CMS
- Git & GitHub

---

## 📂 Project Structure

terraform-ec2-strapi-task/
│
├── main.tf
├── provider.tf
├── variables.tf
├── outputs.tf
│
└── modules/
└── ec2/
├── main.tf
├── variables.tf
└── outputs.tf



---

## ⚙️ Infrastructure Details

### 🔑 Key Pair
- RSA 4096-bit key generated using `tls_private_key`
- Public key uploaded to AWS
- Private key saved locally as `.pem` file
- Proper file permissions applied

### 🌐 Networking
- Default VPC used
- Security group created
- Ports opened:
  - 22 (SSH)
  - 1337 (Strapi)

### 🖥️ EC2 Instance
- Instance Type: `t2.medium`
- Public IP associated
- Key pair attached
- Managed fully by Terraform

---

## 🚀 Deployment Steps

### 1️⃣ Initialize Terraform

```bash
terraform init


2️⃣ Plan Infrastructure
terraform plan

3️⃣ Apply Configuration
terraform apply

4️⃣ Connect to EC2
chmod 400 terra-key-ec2.pem
ssh -i terra-key-ec2.pem ubuntu@<public-ip>


📦 Strapi Deployment
Install Node.js (v20)
sudo apt update
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

Clone Project
git clone https://github.com/namitagrawal2001/strapi-local-setup.git
cd strapi-local-setup

Setup Environment
cp .env.example .env

Install Dependencies
npm install

Build & Start
npm run build
HOST=0.0.0.0 npm run start

🌍 Application Access

Strapi Admin Panel accessible at:



