terraform {
  backend "s3" {
    bucket = "primuslearning-terraform"
    key    = "primus-march/terraform-march-state"
    region = "us-east-1"
   # encrypt = true
    dynamodb_table = "terraform-lock"
  }
}
