resource "aws_key_pair" "levelup_key"{
  key_name = "levelup_key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "example_instance" {
  ami = lookup(var.AMIs, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name = aws_key_pair.levelup_key.key_name
  availability_zone = "us-east-1a"
  vpc_security_group_ids = [aws_security_group.allow-levelup-ssh.id]
  subnet_id = aws_subnet.levelupvpc-public-1.id
  tags = {
    Name = "demoinstance"
  }
  
}

output "public_ip" {
  value = aws_instance.example_instance.public_ip
}