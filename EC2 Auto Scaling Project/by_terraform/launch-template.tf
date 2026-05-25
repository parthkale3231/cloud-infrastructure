data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }
}

resource "aws_launch_template" "app_template" {
  name_prefix   = "free-tier-template"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  vpc_security_group_ids = [
    aws_security_group.asg_sg.id
  ]

  user_data = base64encode(<<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "Hello from Terraform Auto Scaling Project" > /var/www/html/index.html
              EOF
  )

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "asg-instance"
    }
  }
}