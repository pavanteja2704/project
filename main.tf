resource "google_compute_instance" "web" {
  name         = "web-instance"
  machine_type = "custom-2-8192" // 4 cores, 8GB memory
  zone         = "us-central1-b"
 
  boot_disk {
    initialize_params {
      image = "rhel-cloud/rhel-9" // RHEL 9 image
      size  = 50 // 50 GB boot disk
    }
  }

  network_interface {
    network = "default"
    access_config {
      // Include any access configuration if needed
    }
  }
 
  tags = ["amazone-clone"]

  metadata_startup_script = file("./install_jenkins.sh")
}