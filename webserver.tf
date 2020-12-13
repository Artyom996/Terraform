provider "aws" {
  region = "eu-central-1"
}

#elastic_ip - privyazka ip k serveru po id

resource "aws_eip" "my_static_ip" {
  instance = aws_instance.MyWEB.id
}

resource "aws_instance" "MyWEB" {
  ami                    = "ami-0bd39c806c2335b95"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_web_server.id]
  user_data              = templatefile("script_httpd.txt.tpl", { firstname = "Artyom", lastname = "Dubinka", names = ["Maksim", "BAKACH", "opeq"] })
  tags = {
    NAme  = "MyTerraform"
    Owner = "Artyom"
  }
  lifecycle {
    create_before_destroy = true
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
