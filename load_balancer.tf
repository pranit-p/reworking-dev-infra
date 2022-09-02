resource "aws_lb" "backend_load_balancer" {
  name                       = "reworking-dev-lb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.servers_security_group.id]
  subnets                    = [aws_subnet.reworking_dev_public_subnet.id, aws_subnet.reworking_dev_private_subnet.id]
  enable_deletion_protection = false
}

resource "aws_lb_target_group" "backend_load_balancer_target_group" {
  name     = "backend-lb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.reworking_dev_vpc.id
}

resource "aws_lb_target_group_attachment" "backend_load_balancer_target_group_attachment" {
  target_group_arn = aws_lb_target_group.backend_load_balancer_target_group.arn
  target_id        = aws_instance.backend_server.id
  port             = 80
}

resource "aws_alb_listener" "backend_load_balancer_listener" {
  load_balancer_arn = aws_lb.backend_load_balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.backend_load_balancer_target_group.arn
    type             = "forward"
  }
}

