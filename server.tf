terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.64.0"
    }
  }
}

provider "aws" {
region = "us-east-1"
}
resource "aws_instance" "myawsserver" {
  ami = "ami-0e54eba7c51c234f6"
  instance_type = "t2.micro"
  vpc_security_group_ids  = [aws_security_group.venket_ssh.id]
  key_name = "venket-keypair"

  tags = {
    Name = "venket-DevOps-batch-server"
    env = "Production"
    owner = "venket"
  }
  provisioner "local-exec" {
    command = "echo The servers IP address is ${self.public_ip} && echo ${self.public_ip} > /tmp/inv"
  }
}

