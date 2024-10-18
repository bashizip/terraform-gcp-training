terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

module "instances" {
  source = "./instances"
}


module "storage" {
  source = "./storage"
}

# remote backend- terraform init, then yes

terraform {
  backend "gcs" {
    bucket  = "tf-bucket-810044"
    prefix  = "terraform/state"
  }
}


# network module

 resource "google_compute_instance"  "tf-instance-2" {
  name         = "tf-instance-2" 
  machine_type = "e2-standard-2"
  boot_disk {
    initialize_params {
      image = "debian-11-bullseye-v20241009"
    }
  }
  network_interface {
    network = "tf-vpc-226092"
    subnetwork = "subnet-01"
    access_config {
    }
  }

   metadata_startup_script = <<-EOT
        #!/bin/bash
    EOT
  allow_stopping_for_update = true
}



# network module

module "network" {
  source  = "terraform-google-modules/network/google"
  version = "~> 9.3"
  # insert the 3 required variables here
  network_name = "tf-vpc-226092"
  project_id = var.project_id
  routing_mode = "GLOBAL"

   subnets = [
      {
        subnet_name = "subnet-01"
        subnet_ip   =  "10.10.10.0/24"
        subnet_region = "us-west1"
       },
      {
         subnet_name  = "subnet-02"
         subnet_ip    =  "10.10.20.0/24"
         subnet_region = "us-west1"
   }
  ]

}

# firewall 

resource "google_compute_firewall" "tf-firewall" {
  name    = "tf-firewall"
  network = "tf-vpc-226092"

  allow {
    protocol = "tcp"
    ports    = ["80"]
     }

      source_ranges = ["0.0.0.0/0"] 
}

