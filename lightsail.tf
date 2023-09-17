

resource "aws_lightsail_instance" "example_instance" {
  name              = "example-instance"
  availability_zone = "us-east-1a"
  blueprint_id      = "amazon_linux_2"
  bundle_id         = "nano_2_0"
  key_pair_name     = "example-key-pair"
  user_data         = <<-EOT
    #!/bin/bash
    sudo yum install httpd -y
    sudo systemctl start httpd
    sudo systemctl enable httpd
    sudo echo "<h1>This Server is created using Terraform </h1>" >> /var/www/html/index.html
  EOT
}

resource "aws_lightsail_key_pair" "example_key_pair" {
  name       = "example-key-pair"
  public_key = file("<path_to_public_ssh_key>")
}

output "public_ip" {
  value = aws_lightsail_instance.example_instance.public_ip_address
}
