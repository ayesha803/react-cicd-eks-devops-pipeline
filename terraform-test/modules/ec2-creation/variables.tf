variable "sg_name" {
  type        = string
  description = "Name of the security group"
}

variable "sg_description" {
  type        = string
  description = "Description of the security group"
}

variable "subnet_id_value" {
  type        = string
  description = "ID of the subnet to use for the EC2 instance"
}

variable "vpc_id_value" {
  type        = string
  description = "ID of the VPC to use for the security group"
  
}

variable "key_name_value" {
  description = "Name of the AWS key pair to use for EC2 instance"
  type        = string
}

variable "ami_value" {
  description = "AMI ID to use for the EC2 instance"
  type        = string
}

variable "iam_role_value" {
  description = "Name of the IAM role to attach to the EC2 instance"
  type        = string
}