# Terraform/Ansible Example 
This repository is a code example to demostrate an EC2 instance provisioned by Terraform and Ansible to bootstrap the instance by installing OpenJDK and Tomcat.

## Versions
- Ubuntu 19.04 (Disco) - ami-0f6051c038d0c04b9
- openjdk-8-jdk (8u222-b10-1ubuntu1~19.04.1)
- Package: tomcat9 (9.0.16-3ubuntu0.19.04.1) 

## Worflow
- Terraform provisions: 
    - AWS network including `aws_vpc`, `aws_internet_gateway`, `aws_route_table`, `aws_subnet`, and `aws_route_table_association`
    - AWS Security Groups
    - `ansible-server`
    - `tomcat-server` 
- Post provisioning of `tomcat-server`, `remote-exec` connects to `ansible-server` via SSH and runs `ansible-playbook` usign the `tomcat-server` public IP as opposed to an inverntory file.      

## Caveats
- Use of `StrictHostKeyChecking no` in the `~/.ssh/config` is for demonstration purposes only and not advised for production use.


