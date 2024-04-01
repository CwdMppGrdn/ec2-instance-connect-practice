#!/bin/bash
sudo dnf update -y

# awscliのインストール
sudo dnf install -y python3
sudo dnf install -y python3-pip
sudo pip3 install awscli

# cloudwatch-agent、ssm-agent、jqのインストール
dnf install -y amazon-cloudwatch-agent amazon-ssm-agent jq
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json -s
systemctl enable amazon-ssm-agent
systemctl start amazon-ssm-agent

# ec2-instance-connectのインストール
mkdir /tmp/ec2-instance-connect
curl https://amazon-ec2-instance-connect-us-west-2.s3.us-west-2.amazonaws.com/latest/linux_amd64/ec2-instance-connect.rpm -o /tmp/ec2-instance-connect/ec2-instance-connect.rpm
curl https://amazon-ec2-instance-connect-us-west-2.s3.us-west-2.amazonaws.com/latest/linux_amd64/ec2-instance-connect-selinux.noarch.rpm -o /tmp/ec2-instance-connect/ec2-instance-connect-selinux.rpm
sudo dnf install -y /tmp/ec2-instance-connect/ec2-instance-connect.rpm /tmp/ec2-instance-connect/ec2-instance-connect-selinux.rpm
