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

    

    
