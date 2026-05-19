terraform {
  backend "gcs" {
    bucket  = var.state_bucket_name
    prefix  = local.bucket_path_prefix
  }
}
