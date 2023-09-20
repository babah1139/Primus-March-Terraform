output "server-ip" {
  value = aws_instance.Primus-server.public_ip
}

output "vpc_id" {
  value = aws_vpc.primus-vpc.id
}

output "server-arn" {
  value = aws_instance.Primus-server.arn
}