

module "vpc-creation" {
  source = "./modules/vpc-creation" 
}

module "iam-role-creation" {
  source = "./modules/iam-role-creation"
}

module "ec2-creation" {
  source = "./modules/ec2-creation"
  ami_value = var.ami_value
  key_name_value = var.key_name_value
  sg_name = var.sg_name
  sg_description = var.sg_description
  subnet_id_value = module.vpc-creation.subnet_id
  vpc_id_value = module.vpc-creation.vpc_id
  iam_role_value = module.iam-role-creation.jenkins-ec2-role_name

}