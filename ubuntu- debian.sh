#!/bin/bash
#install docker
    apt-get update
    apt-get install -y git
    apt-get install -y docker.io git
    systemctl start docker
    echo " Docker installation done"
    systemctl enable docker
    systemctl restart docker
# Clone the repository
    git clone https://github.com/pavanteja2704/webapp.git /tmp/your-repo
 
    # Run the httpd container
    docker run -d -p 4102:80 --name apache-container httpd
 
    # Wait for the container to start
    sleep 10
 
    # Copy the repository files to the document root
    docker cp /tmp/your-repo/. apache-container:/usr/local/apache2/htdocs/
 
    # Restart the container to ensure Apache serves the new content
    docker restart apache-container

    #Installation Of Prometheus 
    wget https://github.com/prometheus/prometheus/releases/download/v2.50.0-rc.1/prometheus-2.50.0-rc.1.linux-amd64.tar.gz

    tar xzvf prometheus-2.50.0-rc.1.linux-amd64.tar.gz

    cd prometheus-2.50.0-rc.1.linux-amd64

    ./prometheus &

    echo  "{
          "metrics-addr" : "0.0.0.0:9323",
          "experimental" : true
          }" >  /etc/docker/daemon.json

    #google cloud sdk 
    sudo apt-get install -y curl apt-transport-https ca-certificates gnupg
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
    sudo apt-get update
    sudo apt-get install -y google-cloud-sdk
    echo "gcloud CLI installation completed"

 # Install Trivy

sudo apt-get update
 
sudo apt-get install -y wget apt-transport-https ca-certificates gnupg lsb-release
 
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list
 
sudo apt-get update

sudo apt-get install -y trivy

trivy --version
 
echo "Trivy installation completed"

# Install Terraform
sudo apt-get update
 
# Install required dependencies
sudo apt-get install -y wget unzip
 
# Download the latest version of Terraform
TERRAFORM_VERSION="1.8.5"
wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
 
# Unzip the downloaded file
unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
 
# Move the Terraform binary to a directory included in your system's PATH
sudo mv terraform /usr/local/bin/
 
# Verify installation
terraform --version
 
echo "Terraform installation completed"




    
