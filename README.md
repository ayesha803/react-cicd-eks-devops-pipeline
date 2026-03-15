
**CI/CD Pipeline for Containerized React Application**
**Project Overview**

This project demonstrates an end-to-end DevOps CI/CD pipeline for deploying a containerized React application on AWS.

The pipeline automates the process of building, containerizing, and deploying the application to a Kubernetes cluster running on Amazon Elastic Kubernetes Service (EKS).

The application is exposed externally using AWS Load Balancer Controller, which provisions an Application Load Balancer for external access.

eksctl create cluster \
--name trend-cluster \
--region us-east-1 \
--nodegroup-name trend-nodes \
--node-type t3.small \
--nodes 2

**Architecture**

The deployment pipeline follows this workflow:

GitHub → Jenkins → Docker Build → Docker Hub → Kubernetes (EKS) → AWS Load Balancer

**Technologies Used**

**Cloud Platform**

AWS

**Infrastructure as Code**

Terraform

**CI/CD**

Jenkins

GitHub Webhooks

**Containerization**

Docker

Docker Hub

**Container Orchestration**

Kubernetes

Amazon EKS

Ingress

AWS Load Balancer Controller

**Monitoring**

Prometheus

Grafana


**Project Components**

1. Application

A sample React application cloned from the provided repository and configured to run on port 3000.

2. Dockerization

The application is containerized using a Dockerfile.

Steps:

Build Docker image

Test container locally

Push image to Docker Hub
3. Infrastructure Provisioning

Infrastructure is created using Terraform, including:

VPC

IAM roles

EC2 instance for Jenkins

EKS cluster

Terraform commands used:
terraform init
terraform plan
terraform apply

Terraform state files are used to maintain infrastructure state.

4. CI/CD Pipeline

A Jenkins declarative pipeline automates the build and deployment process.

Pipeline stages:

Pull source code from GitHub

Build Docker image

Push image to Docker Hub

Deploy application to Kubernetes

The pipeline is triggered automatically using GitHub Webhooks.


5. Kubernetes Deployment

The application is deployed to Amazon EKS using Kubernetes manifests.

Resources created:

Deployment

Service

Ingress

Commands used:

kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f ingress.yaml

6. Ingress Configuration

The AWS Load Balancer Controller is installed using Helm to enable external access to the application.

This controller automatically provisions an Application Load Balancer (ALB).

7. Application Access

Once deployment is complete, the application can be accessed through the ALB DNS endpoint created by the Kubernetes Ingress.


8. Monitoring

Monitoring is implemented using Prometheus and Grafana to observe the health and performance of the Kubernetes cluster and deployed application.

Prometheus

Prometheus is deployed in the Kubernetes cluster to collect metrics from cluster components and application workloads.

Key features:

Collects metrics from Kubernetes nodes and pods

Stores time-series data for monitoring

Provides query capabilities for analyzing system performance

Grafana

Grafana is used to visualize metrics collected by Prometheus.

Features:

Interactive dashboards for system monitoring

Visualization of Kubernetes cluster metrics

Monitoring application performance and resource usage







