resource "tls_private_key" "tls_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "custom_key_pair" {
  key_name   = "server-connection-key" # Create "myKey" to AWS!!
  public_key = tls_private_key.tls_private_key.public_key_openssh

  provisioner "local-exec" { # Create "myKey.pem" to your computer!!
    command = "echo '${tls_private_key.tls_private_key.private_key_pem}' > ./ssh-connection-key.pem"
  }
}

resource "aws_security_group" "servers_security_group" {
  name        = "reworking-dev-application-sg"
  description = "Allow HTTP, HTTPS and SSH inbound traffic"
  vpc_id      = aws_vpc.reworking_dev_vpc.id

  ingress {
    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
  }

  ingress {
    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    to_port     = 443
  }

  ingress {
    protocol = "tcp"


    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}

resource "aws_instance" "frontend_server" {
  ami                         = local.server_ami
  instance_type               = local.instance_type
  iam_instance_profile        = aws_iam_instance_profile.backend_server_profile.name
  user_data                   = templatefile("${path.module}/frontend_script.sh.tpl", {})
  key_name                    = aws_key_pair.custom_key_pair.key_name
  vpc_security_group_ids      = [aws_security_group.servers_security_group.id]
  subnet_id                   = aws_subnet.reworking_dev_public_subnet_first.id
  associate_public_ip_address = true
  tags = {
    Name = "Frontend-Server"
  }
}

resource "aws_instance" "backend_server" {
  ami                         = local.server_ami
  instance_type               = local.instance_type
  key_name                    = aws_key_pair.custom_key_pair.key_name
  iam_instance_profile        = aws_iam_instance_profile.backend_server_profile.name
  vpc_security_group_ids      = [aws_security_group.servers_security_group.id]
  subnet_id                   = aws_subnet.reworking_dev_public_subnet_first.id
  user_data                   = templatefile("${path.module}/backend_script.sh.tpl", {})
  associate_public_ip_address = true
  tags = {
    Name = "Backend-Server"
  }
}