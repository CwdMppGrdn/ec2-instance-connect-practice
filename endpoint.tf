resource "aws_ec2_instance_connect_endpoint" "ec2_instance_connect" {
    subnet_id        = aws_subnet.private_a.id
    security_group_ids = [aws_security_group.endpoint.id]
    preserve_client_ip = true
    tags = {
        Name = "eic-test"
    }
}
