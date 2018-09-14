/*
module "main-vpc" {
  source = "../modules/vpc"
  ENV = "dev"
  AWS_REGION = "${var.AWS_REGION}"
}

module "instances" {
  source = "../modules/instances"
  ENV = "dev"
  VPC_ID = "${module.main-vpc.vpc_id}"
  PUBLIC_SUBNETS = ["${module.main-vpc.public_subnets}"]
}
*/

module "s3" {
  source = "../modules/s3"
  ENV = "dev"
  AWS_REGION = "${var.AWS_REGION}"
  AWS_BACKUP_REGION = "${var.AWS_BACKUP_REGION}"
}
