provider "aws" {
  region = "us-east-2"
}

module "vpc" {
  source         = "./modules/vpc"
  vpc_cidr_block = "10.0.0.0/16"
}

module "security_group" {
  source      = "./modules/security-group"
  vpc_id      = module.vpc.vpc_id
}

module "ec2" {
  source       = "./modules/ec2"
  instance_type = "t2.micro"
  ami_id       = "ami-0c55b159cbfafe1f0"
  subnet_id    = module.vpc.public_subnet_id
  security_group_id = module.security_group.security_group_id
}
