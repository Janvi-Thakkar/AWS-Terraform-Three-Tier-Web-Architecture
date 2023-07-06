#Application Load Balancer
module "alb" {
  source = "terraform-aws-modules/alb/aws"

  name = "${var.practice_tag}-alb"

  load_balancer_type = "application"

  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.public_subnets
  security_groups = [module.alb_sg.security_group_id]

  target_groups = [
    {
      name             = "${var.practice_tag}-lb-target"
      backend_port     = 80
      backend_protocol = "HTTP"
      vpc_id           = module.vpc.vpc_id

      stickiness = {
        enabled = true
        type    = "lb_cookie"
      }
    }
  ]

  # HTTPS Listner
  https_listeners = [
    {
      port            = 443
      protocol        = "HTTPS"
      certificate_arn = data.aws_acm_certificate.issued.arn
      stickiness = {
        enabled = true
        type    = "lb_cookie"
      }
      target_group_index = 0
    }
  ]

  # Redirect HTTP Traffic to HTTPS
  http_tcp_listeners = [
    {
      port        = 80
      protocol    = "HTTP"
      action_type = "redirect"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  ]

  tags = {
    Owner = var.Owner
    Lab   = var.lab_tag
    Name  = "${var.practice_tag}-alb"
  }

}

#Auto-Scaling Group
module "asg" {
  source     = "terraform-aws-modules/autoscaling/aws"
  depends_on = [module.alb]

  # Autoscaling Group
  name                = "${var.practice_tag}-asg"
  min_size            = var.ec2_min
  max_size            = var.ec2_max
  desired_capacity    = var.ec2_desire
  health_check_type   = "EC2"
  vpc_zone_identifier = module.vpc.private_subnets

  #Lauch Template
  create_launch_template = true
  launch_template_name        = "${var.practice_tag}-ec2-lauch"
  launch_template_description = "ec2 launch template"
  user_data                   = base64encode(templatefile("${path.module}/user_data.tftpl", { db_name = var.rds_fqdn }))
  instance_type               = var.instance_type
  image_id                    = var.ami_id
  key_name                    = aws_key_pair.ec2Key.key_name
  security_groups             = [module.ec2_sg.security_group_id]

  # IAM Role & Instance Profile
  create_iam_instance_profile = true
  iam_role_name               = "${var.practice_tag}-ec2-ssm"
  iam_role_path               = "/ec2/"
  iam_role_description        = "IAM role ec2 SSM"
  iam_role_tags = {
    CustomIamRole = "Yes"
  }
  iam_role_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

  #EC2 Tags
  tag_specifications = [
    {
      resource_type = "instance"
      tags = {
        Owner = var.Owner
        Lab   = var.lab_tag
        Name  = "${var.practice_tag}-ec2"
      }
    }
  ]

  capacity_reservation_specification = {
    capacity_reservation_preference = "open"
  }

  target_group_arns = module.alb.target_group_arns

  tags = {
    Owner = var.Owner
    Lab   = var.lab_tag
    Name  = "${var.practice_tag}-asg"
  }
}

#EC2 Key Pair
resource "aws_key_pair" "ec2Key" {
  public_key = file("ec2.pub")
  key_name   = "ec2KeyPair"

  tags = {
    Owner = var.Owner
    Lab   = var.lab_tag
    Name  = "${var.practice_tag}-keypair"
  }
}

#SSL Certificate for ALB
data "aws_acm_certificate" "issued" {
  domain   = var.domain
  statuses = ["ISSUED"]
}
