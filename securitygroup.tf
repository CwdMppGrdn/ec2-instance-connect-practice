resource "aws_security_group" "ec2" {
  vpc_id = aws_vpc.example.id
  name   = "scg-ec2"
}

resource "aws_vpc_security_group_ingress_rule" "ingress_endpoint_ssh" {
  security_group_id = aws_security_group.ec2.id
    ip_protocol = "tcp"
    from_port   = 22
    to_port     = 22
    referenced_security_group_id = aws_security_group.endpoint.id
}

resource "aws_vpc_security_group_egress_rule" "egress_internet" {
  security_group_id = aws_security_group.ec2.id
    ip_protocol = "tcp"
    from_port   = 0
    to_port     = 0
    cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_security_group" "endpoint" {
  vpc_id = aws_vpc.example.id
  name   = "scg-endpoint"
}

resource "aws_vpc_security_group_egress_rule" "egress_ec2_ssh" {
  security_group_id = aws_security_group.endpoint.id
    ip_protocol = "tcp"
    from_port   = 22
    to_port     = 22
    referenced_security_group_id = aws_security_group.ec2.id
}
