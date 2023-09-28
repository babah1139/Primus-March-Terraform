/*module "babah-server" {
  source = "./modules/ec2"
  subnetId = module.network.subnetId
  sg = module.babah-sg.sg
}


module "network" {
  source = "./modules/network"
  name = "primus"
  sbn-cidr = "10.0.1.0/24"

}

module "babah-sg" {
  source = "./modules/security"
  vpcId = module.network.vpcId
  sgName = "primus-sg"
  
}

module "joshua" {
  source = "./modules/security"
  vpcId = module.network.vpcId
  sgName = "Joshua"
  
}

module "babah-vpc" {
  source = "./modules/network"
  vpc-cidr = "10.10.0.0/16"
  name = "babah"
  sbn-cidr = "10.10.0.0/24"
  
}*/

module "test-vpc" {
  source = "terraform-aws-modules/vpc/aws"
  cidr = "10.20.0.0/16"
  name = "test-vpc"
  azs = ["eu-west-3a", "eu-west-3b"]
  public_subnets = ["10.20.0.0/24"]
  private_subnets = ["10.20.1.0/24"]
}


module "my-primus-s3" {
  source = "terraform-aws-modules/s3-bucket/aws"
  bucket = "my-primus-babah-bucket-com"
  

  tags = {
    env = "Prod"
    owner= "babah"

  }
  
}