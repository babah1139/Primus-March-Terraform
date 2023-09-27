module "babah-server" {
  source = "./modules/ec2"
  subnetId = module.network.subnetId
  sg = module.babah-sg.sg
}


module "network" {
  source = "./modules/network"

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