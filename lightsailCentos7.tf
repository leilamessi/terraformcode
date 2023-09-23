

resource "aws_lightsail_instance" "centos_server" {
  name              = "centos-server"
  availability_zone = "us-east-1a"  
  blueprint_id      = "centos_7_1901_01"
   bundle_id         = "nano_2_0"
  user_data = <<-USERDATA
    #!/bin/bash
    sudo yum update -y
    sudo yum install unzip wget httpd -y
    sudo wget https://github.com/utrains/static-resume/archive/refs/heads/main.zip
    sudo unzip main.zip
    sudo rm -rf /var/www/html/*
    sudo cp -r static-resume-main/* /var/www/html/
    sudo systemctl start httpd
    sudo systemctl enable httpd

    # Output the public IP
    echo "Public IP: \$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)"
    USERDATA
}

output "public_ip_1" {
  value = aws_lightsail_instance.centos_server.public_ip_address
}
