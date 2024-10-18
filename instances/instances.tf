
resource "google_compute_instance"  "tf-instance-1" {
  name         = "tf-instance-1" 
  machine_type = "e2-micro"
  boot_disk {
    initialize_params {
      image = "debian-11-bullseye-v20241009"
    }
  }
  network_interface {
    network = "default"

    #  network = "tf-vpc-226092"
    #  subnetwork = "subnet-01"
    access_config {
     
    }
  }

  metadata_startup_script = <<-EOT
        #!/bin/bash
    EOT
allow_stopping_for_update = true

}

resource "google_compute_instance"  "tf-instance-2" {
  name         = "tf-instance-2" 
  machine_type = "e2-micro"
  boot_disk {
    initialize_params {
      image = "debian-11-bullseye-v20241009"
    }
  }
  network_interface {
    network = "default"
    #  network = "tf-vpc-226092"
    #  subnetwork = "subnet-01"
    access_config {
    }
  }

   metadata_startup_script = <<-EOT
        #!/bin/bash
    EOT
  allow_stopping_for_update = true
}