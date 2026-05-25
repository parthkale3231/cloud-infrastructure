resource "aws_launch_template" "app_lt" {
  name_prefix   = "prod-app-lt"
  image_id      = "ami-0236922087fa98b6e"
  instance_type = "t3.micro"

  
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.app_sg.id]
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.name
  }

  user_data = base64encode(file("userdata.sh"))
}