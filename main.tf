terraform {
    required_version = ">= 0.12.13"
}
provider "aws" {
    region = "${var.aws_region}"
}

resource "tls_private_key" "example" {
  algorithm   = "RSA"
  ecdsa_curve = 4096
}

resource "aws_key_pair" "ansible-demo-key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.example.public_key_openssh
}

