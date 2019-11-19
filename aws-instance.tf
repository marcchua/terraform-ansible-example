resource "aws_instance" "tomcat-server" {
  ami                     = "${var.ami_id}" 
  instance_type           = "${var.instance_type}"
  key_name                = "${var.key_name}"
  subnet_id               = aws_subnet.main.id
  vpc_security_group_ids  = [aws_security_group.main.id]

  tags = {
    Name = "ansible-demo"
  }

  provisioner "local-exec" {
    command = "sleep 30"
  }

  connection {
    type = "ssh"
    host = aws_instance.ansible-server.public_ip
    user = "ubuntu"
    private_key = tls_private_key.example.private_key_pem 
    timeout = "30"
  }  

  provisioner "remote-exec" {
    inline = [   
        "ansible-playbook ~/ansible-samples/tomcat-server.yml -e 'ansible_python_interpreter=/usr/bin/python3' -u ubuntu --private-key ~/.ssh/id_rsa -i ${aws_instance.tomcat-server.public_ip},"
    ]
  }

  depends_on = ["aws_instance.ansible-server"]

}







