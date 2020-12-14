provider "aws" {

}
# Late-ubuntu
data "aws_ami" "latest_ubuntu" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

output "latest_ubuntu_ami_id" {
  value = data.aws_ami.latest_ubuntu.id
}

output "latest_ubuntu_ami_name" {
  value = data.aws_ami.latest_ubuntu.name
}
# LAte-amazon
data "aws_ami" "latest_amazon" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }
}

output "latest_amazon_ami_id" {
  value = data.aws_ami.latest_amazon.id
}

output "latest_amazon_ami_name" {
  value = data.aws_ami.latest_amazon.name
}

# LAte_WinSERVER

data "aws_ami" "latest_win_serv" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["Windows_Server-2019-*"]
  }
}

output "latest_win_server_ami_id" {
  value = data.aws_ami.latest_win_serv.id
}

output "latest_win_server_ami_name" {
  value = data.aws_ami.latest_win_serv.name
}
