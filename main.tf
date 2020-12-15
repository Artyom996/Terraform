provider "aws" {

}

#---------------------------------------------

data "aws_availability_zones" "available" {}
data "aws_ami" "latest_amazon" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }
}

#----------------------------------------------

resource "aws_security_group" "my_web_server" {
  name = "dinamic_sequrity_group"

  dynamic "ingress" {
    for_each = ["80", "443", "8080", "22"]
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

  tags = {
    Name = "Dinamic_security_group"
  }
}

#--------------------------------------------

resource "aws_launch_configuration" "as_conf" {
  #name            = "Web_Server-Highly-Available"
  name_prefix     = "Web_Server-Highly-Available-"
  image_id        = data.aws_ami.latest_amazon.id
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.my_web_server.id]
  user_data       = file("user_data.sh")

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "web" {
  name                 = "ASG-${aws_launch_configuration.as_conf.name}"
  launch_configuration = aws_launch_configuration.as_conf.name
  min_size             = 2
  max_size             = 2
  min_elb_capacity     = 2
  vpc_zone_identifier  = [aws_default_subnet.zone1.id, aws_default_subnet.zone2.id]
  health_check_type    = "ELB"
  load_balancers       = [aws_elb.web.name]
  dynamic "tag" {
    for_each = {
      Name   = "WebServer in ASG"
      TAGKEY = "TAGVALUE"
    }
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_elb" "web" {
  name               = "WebServer-HA-LB"
  availability_zones = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1]]
  security_groups    = [aws_security_group.my_web_server.id]
  listener {
    instance_port     = "80"
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 10
  }
  tags = {
    Name = "WebServer-HA-ELB"
  }
}

resource "aws_default_subnet" "zone1" {
  availability_zone = data.aws_availability_zones.available.names[0]
}
resource "aws_default_subnet" "zone2" {
  availability_zone = data.aws_availability_zones.available.names[1]
}

output "webloadbalancer_url" {
  value = aws_elb.web.dns_name
}
