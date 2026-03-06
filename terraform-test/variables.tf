variable "sg_name" {
  type        = string
  description = "Name of the security group"
}

variable "sg_description" {
  type        = string
  description = "Description of the security group"
}

variable "key_name_value" {
  description = "Name of the AWS key pair to use for EC2 instance"
  type        = string
}

variable "ami_value" {
  description = "AMI ID to use for the EC2 instance"
  type        = string
}