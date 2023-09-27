output "subnetId" {
  value = aws_subnet.primus-subnet.id
}

output "vpcId" {
  value = aws_vpc.primus-vpc.id 
}