

resource "aws_lightsail_instance" "example_instance" {
  name              = "example-instance"
  availability_zone = "us-east-1a"
  blueprint_id      = "amazon_linux_2"
  bundle_id         = "nano_2_0"
  user_data         = <<-EOT
    #!/bin/bash
    sudo yum install httpd -y
    sudo systemctl start httpd
    sudo systemctl enable httpd
    sudo echo "<h1>This Server is created using Terraform </h1>" >> /var/www/html/index.html


 # Output the public IP
    echo "Public IP: \$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)"
    EOT
}
output "public_ip" {
  value = aws_lightsail_instance.example_instance.public_ip_address
}