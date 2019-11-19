#!/bin/bash
sudo apt-get update 
sudo apt-get install software-properties-common -y
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt install ansible -y
cd /home/ubuntu
sudo git clone https://github.com/marcchua/ansible-samples.git

sudo cat << EOT > /home/ubuntu/.ssh/id_rsa
${private_key_pem}
EOT

sudo cat <<EOF > /home/ubuntu/.ssh/config
Host *
     ForwardAgent no
     ForwardX11 no
     ForwardX11Trusted yes
     User ubuntu
     Port 22
     Protocol 2
     ServerAliveInterval 60
     ServerAliveCountMax 30
     StrictHostKeyChecking no
EOF

sudo chmod 400 /home/ubuntu/.ssh/config
sudo chmod 400 /home/ubuntu/.ssh/id_rsa
sudo chown ubuntu:ubuntu /home/ubuntu/.ssh/config
sudo chown ubuntu:ubuntu /home/ubuntu/.ssh/id_rsa
sudo chown --recursive ubuntu:ubuntu /home/ubuntu/ansible-samples

sudo systemctl restart ssh.service 
sudo systemctl restart sshd.service 