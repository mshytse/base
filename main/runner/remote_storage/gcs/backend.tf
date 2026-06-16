terraform {
  backend "gcs" {
    bucket  = var.state_bucket_name
    prefix  = var.bucket_path_prefix
  }
}
