output "publicip" {
  value = aws_instance.testinstance.public_ip
}

output "publicdns" {
  value = aws_instance.testinstance.public_dns
}

output "privateip" {
  value = aws_instance.testinstance.private_ip
}

output "privatedns" {
  value = aws_instance.testinstance.private_dns
}