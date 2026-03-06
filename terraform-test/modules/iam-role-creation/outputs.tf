output "jenkins-ec2-role_name" {
  value = aws_iam_role.jenkins_role.name
    description = "The name of the created IAM role for Jenkins EC2 instance"
}