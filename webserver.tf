provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "MyWEB" {
  ami                    = "ami-0bd39c806c2335b95"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.my_web_server.id]
  user_data              = <<EOF
#!/bin/bash
yum -y update
yum -y install httpd
echo "<h2>Hello! BOSS<h2>" > /var/www/html/index.html
sudo systemctl start httpd
sudo systemctl enable httpd
EOF
  tags = {
    NAme  = "MyTerraform"
    Owner = "Artyom"
  }
}

resource "aws_security_group" "my_web_server" {
  name        = "webserver_sequrity_group"
  description = "MyFirst"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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
