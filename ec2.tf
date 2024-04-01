resource "aws_iam_instance_profile" "ec2" {
  name = "example_profile"
  role = aws_iam_role.ec2.name
}

resource "aws_instance" "ec2" {
  ami                    = "ami-0014871499315f25a"  #RHEL9.3
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.private_a.id
  associate_public_ip_address = true
  vpc_security_group_ids  = [aws_security_group.ec2.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2.name
  user_data = file("userdata.sh")
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "ec2-eic-connect-practice"
  }
}
