resource "google_compute_instance" "web" {
  name         = "web-app"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  tags = ["http-server"]
 
  boot_disk {
    initialize_params {
      image = "rhel-cloud/rhel-9"
      #image =  "ubuntu-os-cloud/ubuntu-2004-lts"  
      size  = 40 
    }
  }

  network_interface {
    network = "default"
    access_config {
      // Include any access configuration if needed
    }
  }
 
  metadata_startup_script = file("./webapp-docker.sh")
 
}
