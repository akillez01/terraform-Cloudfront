resource "aws_lb" "front_end" {
  name               = "front-end-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sec.id]
  subnets            = aws_subnet.ada_public[*].id

  enable_deletion_protection = false

  tags = {
    Name        = "front-end-lb"
    Environment = var.environment
  }
}

resource "aws_lb_target_group" "ada" {
  name        = "front-end-target-group-${random_id.suffix.hex}"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.ada_vpc.id
  target_type = "instance"

  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 30
    matcher             = "200"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.front_end.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ada.arn
  }
}

resource "aws_lb_target_group_attachment" "front_end" {
  for_each         = { for idx, instance in aws_instance.ada_private_ec2 : idx => instance.id }
  target_group_arn = aws_lb_target_group.ada.arn
  target_id        = each.value
  port             = 80
}
