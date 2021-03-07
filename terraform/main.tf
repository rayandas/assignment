module "networking" {
  source               = "./modules/networking"
}

module "compute" {
  source     = "./modules/compute"
  vpc_security_group_ids = module.networking.security_group
  subnet_id  = module.networking.public_subnet
  depends_on = [module.networking]
}
module "database" {
  source = "./modules/database"
  vpc_security_group_ids = module.networking.security_group
  db_subnet_group_name = module.networking.dbsubnet_group
  depends_on           = [module.networking, module.compute]

}

