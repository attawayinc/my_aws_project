## file ~/my_aws_project/roles/ec2_instances_dep/my_ec2_infra.tf
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "dba-essential" {
  count                       = "5"
  ami                         = "ami-0e342d72b12109f91"
  availability_zone           = "us-east-1a"
  instance_type               = "t2.micro"
  associate_public_ip_address = false
  security_groups             = ["my_sg_01"]
  vpc_security_group_ids      = ["sg-602eff2724d52a0b7"]
  key_name                    = "my_key_01"

  root_block_device {
    delete_on_termination = true
    encrypted             = false
    volume_size           = 15
    volume_type           = "gp2"
  }

  tags = {
    Owner           = "MCAJ"
    Name            = "crash-test-${count.index + 1}"
  }

}
