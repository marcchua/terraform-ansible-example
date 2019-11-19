# Yet Another Terraform/Ansible Example 
This repository is a code example to demostrate an EC2 instance provisioned by Terraform and Ansible to bootstrap the instance by installing OpenJDK and Tomcat. This example consists of two EC2 instances where one of the newly provisioned EC2 Ubuntu instance calls an Ansible server/repository to install a JDK and Tomcat service.

## Versions
- Ubuntu 19.04 (Disco) - ami-0f6051c038d0c04b9
- openjdk-8-jdk (8u222-b10-1ubuntu1~19.04.1)
- Package: tomcat9 (9.0.16-3ubuntu0.19.04.1) 
- Terraform 0.12.14 or greater

## Worflow
- Terraform provisions: 
    - AWS network including `aws_vpc`, `aws_internet_gateway`, `aws_route_table`, `aws_subnet`, and `aws_route_table_association`
    - AWS Security Groups
    - `ansible-server`
    - `tomcat-server` 
- Post provisioning of `tomcat-server`, `remote-exec` connects to `ansible-server` via SSH and runs `ansible-playbook` using the `tomcat-server` public IP via the `-i` option in lieu of an inventory file.      

![TF/Ansible Workflow](/images/tf-workflow.png)

## Terraform Cloud
The following Terraform and Environment Variables are required when running the example:

![TF/Ansible TFE](/images/TfAnsible-TFE.png)

## Expected Output
After Ansible executes a playbook on the new EC2 instance, verify the Tomcat output by going to the following URL:

`http://{tomcat-server-public_ip}:8080`

where `{tomcat-server-public_ip}` is the IP address for the `tomcat-server` shown in the Terraform output.

## Caveats
- Use of `StrictHostKeyChecking no` in the `~/.ssh/config` is for demonstration purposes only and not advised for production use
- Terraform version 0.12.14 and later is required due to the adoption of 0.12 first-class expression syntax



