output "tls_private_key" {
  value = tls_private_key.example.private_key_pem 
}

output "tomcat-server-public_ip" {
  value = aws_instance.tomcat-server.*.public_ip
}

output "ansible-server-public_ip" {
  value = aws_instance.ansible-server.*.public_ip
}
