variable "instanceType" {
  default = "t2.micro"
}
variable "keyName" {
  default = "~/.ssh/id_rsa.pub"
}


/*variable "userData" {
  default = "./shellscript.sh"

}*/

variable "subnetId" {
  
}

variable "sg" {
  
}