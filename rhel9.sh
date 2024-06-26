#!/bin/bash
sudo yum install wget -y
sudo wget -O /etc/yum.repos.d/jenkins.repo \
https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade -y
sudo yum install fontconfig java-17-openjdk -y
sudo yum install jenkins -y
sudo systemctl daemon-reload
sudo systemctl enable --now jenkins
echo " Jenkins installation done"

#install docker
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
sudo yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl start docker
echo " Docker installation done"
sudo usermod -aG docker jenkins
echo "jenkins user is added"
echo " new group created"
sudo chmod 777 /var/run/docker.sock
echo " usermod has changed to the docker.sock"
sudo systemctl restart jenkins
echo " jenkins restart done"
docker run -d --name sonar -p 9000:9000 sonarqube:lts-community
 
# install trivy
sudo yum -y update
echo "trivy installation started"
rpm -ivh https://github.com/aquasecurity/trivy/releases/download/v0.18.3/trivy_0.18.3_Linux-64bit.rpm
sudo export PATH="$PATH:/usr/local/bin"
echo " trivy installation done"
 
# Install gcloud CLI
echo " gcloud cli installation started"
sudo tee -a /etc/yum.repos.d/google-cloud-sdk.repo << EOM
[google-cloud-cli]
name=Google Cloud CLI
baseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el9-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=0
gpgkey=https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOM
sudo dnf install libxcrypt-compat.x86_64
sudo dnf install google-cloud-cli
echo " gcloud cli installation done"
 
# Install Node.js 16 and npm
echo " Node instllation started"
sudo dnf install epel-release -y
sudo dnf config-manager --set-enabled powertools
sudo dnf install nodejs npm -y
echo " node and npm installation done"
  
# Install Terraform
echo " terraform installation started"
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install terraform
echo " terraform installation done"
 
# Install kubectl
echo "kubectl installation started"
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.30/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.30/rpm/repodata/repomd.xml.key
EOF
sudo yum update
sudo yum install -y kubectl
sudo export PATH="$PATH:/usr/local/bin"
