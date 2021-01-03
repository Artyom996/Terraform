provider "aws" {
  region = var.region
}

data "aws_ami" "latest_amazon" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }
}

resource "aws_eip" "my_static" {
  instance = aws_instance.my_server.id
  tags     = var.taggs
}


resource "aws_instance" "my_server" {
  ami                    = data.aws_ami.latest_amazon.id
  instance_type          = var.type_instance
  vpc_security_group_ids = [aws_security_group.my_server.id]
  tags                   = merge(var.taggs, { Name = "${var.taggs["Environment"]} Instance" })
  key_name               = "amaz"
  monitoring             = var.monitoring_t
}

resource "aws_security_group" "my_server" {
  name = "dynamic_securitu_group"

  dynamic "ingress" {
    for_each = var.allow_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = var.taggs
}
