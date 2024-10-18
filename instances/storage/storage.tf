resource "google_storage_bucket" "tf-bucket-810044" {
  name          = "tf-bucket-810044"
  location      = "US"
  force_destroy = true

  uniform_bucket_level_access = true
}