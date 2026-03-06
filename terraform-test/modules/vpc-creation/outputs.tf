output "vpc_id" {
  value = aws_vpc.name.id
  description = "The ID of the created VPC"
}

output "subnet_id" {
  value = aws_subnet.sample_subnet.id
  description = "The ID of the created subnet"
}