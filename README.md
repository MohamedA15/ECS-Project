## Table of Contents
1. [Project Overview](#project-overview)  
2. [Architecture](#architecture)  
3. [Folder Structure](#folder-structure)  
4. [Infrastructure](#infrastructure)  
5. [Application](#application)  
6. [Deployment](#deployment)  
7. [Testing](#running-locally)  
  

  ## Project Overview

  This project deploys **Outline**, an open-source collaborative knowledge base platform, on **AWS ECS Fargate** using **Terraform**.  

- Containerised deployment of the Outline knowledge base using Docker Serverless execution on AWS ECS Fargate
- Secure, private infrastructure with VPC, private subnets, and isolated ECS tasks
- Public-facing Application Load Balancer (ALB) handling HTTPS and routing
- Persistent storage via Amazon RDS (PostgreSQL) and caching via Redis
- Infrastructure as code using modular Terraform (VPC, ECS, ALB, RDS, Redis, ACM, SG)
- Automated CI/CD pipeline using GitHub Actions for Docker builds and Terraform deployment
- Domain, DNS, and security protection managed through Cloudflare

## Architecture
<p align="center">
  <img src="images/architecture-diagram.png" alt="Architecture Diagram" width="650">
</p>
