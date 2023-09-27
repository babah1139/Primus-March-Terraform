variable "vpc-cidr" {
  default = "10.0.0.0/16" // this is the CIDR block for our VPC, we will
}
variable "avZone" {
  default = "eu-west-3a" // these are the availability zones that you want to
}

variable "region" {
  default = "eu-west-3" // create your instances in (e.g., us-west-2)
}