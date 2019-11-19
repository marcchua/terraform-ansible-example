data "template_file" "startup_script" {
  template = file("ansible-demo.tpl")

  vars = {
    private_key_pem  = tls_private_key.example.private_key_pem 
  }

}

resource "aws_instance" "ansible-server" {
  ami                     = "${var.ami_id}" 
  instance_type           = "${var.instance_type}"
  key_name                = "${var.key_name}"
  subnet_id               = aws_subnet.main.id
  vpc_security_group_ids  = [aws_security_group.main.id]
  user_data               = data.template_file.startup_script.rendered

  tags = {
    Name = "ansible-server"
  }

  provisioner "local-exec" {
    command = "sleep 30"
  }
}


