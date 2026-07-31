module "vpc" {
  source = "../../modules/vpc"

  project_name         = var.project_name
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.101.0/24", "10.0.102.0/24"]
  availability_zones   = ["${var.aws_region}a", "${var.aws_region}b"]
}
module "security_groups" {
  source = "../../modules/security-groups"

  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
  admin_cidr   = var.admin_cidr
}
module "iam" {
  source = "../../modules/iam"

  project_name = var.project_name
}
module "ec2" {
  source = "../../modules/ec2"

  project_name           = var.project_name
  key_name               = var.key_name
  public_subnet_id       = module.vpc.public_subnet_ids[0]
  private_subnet_id      = module.vpc.private_subnet_ids[0]
  jenkins_sg_id           = module.security_groups.jenkins_sg_id
  app_sg_id               = module.security_groups.app_sg_id
  instance_profile_name  = module.iam.instance_profile_name
}
