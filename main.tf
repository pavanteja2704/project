provider "google" {
  region = "us-east1"
  project = "hardy-binder-411706"
  credentials = xyz.json
}

resource "google_compute_instance" "web" {
  name         = "web-instance-1"
  machine_type = "e2-medium"
  zone         = "us-east1-a"

  tags = ["http-server"]
 
  boot_disk {
    initialize_params {
      image =  "ubuntu-os-cloud/ubuntu-2004-lts"  
      size  = 50 // 50 GB boot disk
    }
  }

  network_interface {
    network = "default"
    access_config {
      // Include any access configuration if needed
    }
  }
 
#metadata_startup_script = file("./install_jenkins.sh")
  metadata_startup_script = <<-EOT
    #!/bin/bash
    #install docker
    apt-get update
    apt-get install -y git
    apt-get install -y docker.io git
    systemctl start docker
    systemctl enable docker
 
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

  EOT
}
# Create a firewall rule to allow HTTP traffic
resource "google_compute_firewall" "fire" {
  name    = "allow-http"
  network = "default"
 
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
 
  target_tags = ["http-server"]
  source_tags = ["webserver"]
}
