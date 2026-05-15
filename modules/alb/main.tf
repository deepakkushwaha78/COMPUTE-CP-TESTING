resource "aws_lb" "alb" {
  name                       = var.alb_name
  internal                   = var.internal
  load_balancer_type         = var.load_balancer_type
  security_groups            = var.security_groups_id
  subnets                    = var.subnets_id
  enable_deletion_protection = var.enable_deletion_protection

  tags = merge(
    {
      "Name" = format("%s", var.alb_name)
    },
    var.tags,
  )

  dynamic "access_logs" {
    for_each = var.enable_logging == true ? local.access_logs_info : []
    iterator = logs_value
    content {
      bucket  = logs_value.value.bucket
      prefix  = logs_value.value.prefix
      enabled = logs_value.value.enabled
    }
  }
}

locals {
  access_logs_info = [
    {
      bucket  = var.logs_bucket
      prefix  = format("%s-alb", var.alb_name)
      enabled = var.enable_logging
    }
  ]
}

resource "aws_alb_listener" "alb_http_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.http_port
  protocol          = var.http_protocol

  default_action {
    type = "redirect"

    redirect {
      port        = tostring(var.https_port)
      protocol    = var.https_protocol
      status_code = var.redirect_status_code
    }
  }
}

resource "aws_alb_listener" "alb_https_listener" {
  count             = var.alb_certificate_arn == "" ? 0 : 1
  load_balancer_arn = aws_lb.alb.arn
  port              = var.https_port
  protocol          = var.https_protocol
  certificate_arn   = var.alb_certificate_arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = var.fixed_response_content_type
      message_body = var.fixed_response_message_body
      status_code  = var.fixed_response_status_code
    }
  }
}
