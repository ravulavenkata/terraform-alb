variable "ENV" {}
variable "AWS_REGION" {}

variable "AWS_BACKUP_REGION" {}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

//CREATE SECURITY GROUP FOR ALB
resource "aws_security_group" "gaia-alb" {
  vpc_id = "${aws_vpc.main.id}"
  name = "gaia-alb-${var.ENV}"
  description = "Security group that allows https for Gaia ALB and all egress traffic"
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  } 
tags {
    Name = "gaia-alb-${var.ENV}"
  }
}

//Create GAIA ALB
resource "aws_lb" "gaia-alb" {
  name               = "gaia-alb-${var.ENV}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.gaia-alb.id}"]
  subnets            = ["${aws_subnet.public.*.id}"]
  tags {
    Environment = "${var.ENV}"
  }
}


resource "aws_alb_target_group" "tg-gaiaapi-elliemae-com" {
  name     = "tg-gaiaapi-elliemae-com-${var.ENV}"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = "${aws_vpc.main.id}"
}
