provider "aws" {
}

data "aws_ami" "latest_version" {
  owners = ["amazon"]
  most_recent = true
  filter {
    name = "name"
    values = ["amzn-ami-hvm-*"]
  }
}

resource "aws_instance" "Jenkins1" {
  ami                    = data.aws_ami.latest_version.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_web_server.id]
  user_data              = file("script_httpd.txt.tpl")
  key_name = "testkey"
  tags = {
    NAme  = "MyTerraform"
    Owner = "Artyom"
  }
}

resource "aws_security_group" "my_web_server" {
  name        = "Jenkins"
  description = "Jenkins"

dynamic "ingress" {
  for_each = ["80", "8080", "22"]
  content {
    from_port = ingress.value
    to_port = ingress.value
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ARTIK"
  }
}
