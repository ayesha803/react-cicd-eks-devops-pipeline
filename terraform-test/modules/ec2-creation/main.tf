resource "aws_security_group" "sg" {
    name = var.sg_name
    description = var.sg_description
    vpc_id = var.vpc_id_value
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 3000
    to_port = 3000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
   }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_key_pair" "name" {
  key_name = var.key_name_value
}

resource "aws_iam_instance_profile" "name" {
  name = "jenkins-instance-profile"
  role = var.iam_role_value
}

resource "aws_instance" "name" {
  ami = var.ami_value
  instance_type = "t3.small"
  vpc_security_group_ids = [aws_security_group.sg.id]
  key_name = data.aws_key_pair.name.key_name
  user_data = file("user-data.sh")
  subnet_id = var.subnet_id_value
 associate_public_ip_address = true 
 iam_instance_profile = aws_iam_instance_profile.name.name

}


