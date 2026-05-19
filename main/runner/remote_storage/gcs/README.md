# GCS Backend

> **Requires OpenTofu v1.8+.** Variable and local references in `backend` blocks are not supported by Terraform.

The backend is configured to change per workspace automatically:

- `bucket` — input variable `state_bucket_name` (defaults to `state_storage_mshytse`)
- `prefix` — local derived from `scalr_current_run` data source, resolves to the current Scalr workspace name

```hcl
locals {
  bucket_path_prefix = data.scalr_current_run.get_ws_name.workspace_name
}

terraform {
  backend "gcs" {
    bucket = var.state_bucket_name
    prefix = local.bucket_path_prefix
  }
}
```

Each workspace stores its state under its own prefix in the bucket, with no manual `-backend-config` flags needed.
