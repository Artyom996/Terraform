output "my_static_ip" {
  value = "aws_eip.my_static.public_ip"
}

output "my_tags_instance" {
  value = "aws_instance.my_server.tags"
}
