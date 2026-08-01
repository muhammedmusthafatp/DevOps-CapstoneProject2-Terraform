# --- Look up the latest Ubuntu 24.04 LTS AMI (Canonical's official account) ---
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# --- Jenkins Agent instance (public subnet) ---
resource "aws_instance" "jenkins_agent" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.jenkins_sg_id]
  key_name                    = var.key_name
  iam_instance_profile        = var.instance_profile_name
  associate_public_ip_address = true

  tags = {
    Name = "${var.project_name}-jenkins-agent"
    Role = "jenkins-agent"
    Project = var.project_name
  }
}

# --- App instance (private subnet) ---
resource "aws_instance" "app" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.app_sg_id]
  key_name               = var.key_name
  iam_instance_profile   = var.instance_profile_name
  
  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  tags = {
    Name = "${var.project_name}-app"
    Role = "app"
    Project = var.project_name
  }
}
