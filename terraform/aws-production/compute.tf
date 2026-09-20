data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "web" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.web.id]
  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    set -e

    dnf install -y nginx

    cat > /usr/share/nginx/html/index.html <<'HTML'
    <!DOCTYPE html>
    <html>
    <head>
      <title>Production DevOps Platform</title>
    </head>
    <body>
      <h1>Production DevOps Platform</h1>
      <p>AWS infrastructure provisioned with Terraform.</p>
      <p>Environment: Production</p>
    </body>
    </html>
    HTML

    systemctl enable nginx
    systemctl start nginx
  EOF

  tags = {
    Name = "production-devops-platform-web"
  }
}
