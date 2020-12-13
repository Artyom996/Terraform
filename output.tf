
output "my_static_ipp" {
  value = aws_eip.my_static_ip.public_ip
}

output "my_sg_id" {
  value = aws_security_group.my_web_server.id
}

output "my_sg_arn" {
  value = aws_security_group.my_web_server.arn
}
