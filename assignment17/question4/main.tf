module "vpc" {
  source = "./modules/vpc"
}

module "alb" {
  source     = "./modules/alb"
  vpc_id     = module.vpc.vpcid
  snid1      = module.vpc.snid1
  snid2      = module.vpc.snid2
  depends_on = [module.vpc]
}

module "lt" {
  source     = "./modules/lt"
  sgid       = module.alb.sgid
  depends_on = [module.alb]
}

module "asg" {
  source     = "./modules/asg"
  lt1id      = module.lt.lt1id
  lt1ver     = module.lt.lt1ver
  snid1      = module.vpc.snid1
  snid2      = module.vpc.snid2
  tg1id      = module.alb.tg1id
  depends_on = [module.lt, module.alb]
}