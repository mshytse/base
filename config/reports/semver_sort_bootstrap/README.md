# Bootstrap: create all SCALRCORE-39212 fixture workspaces in one apply

Runs inside a Scalr VCS/CLI workspace that has the Scalr provider configuration.
Uses `data.scalr_current_run` so workspaces land in the **same environment** as this run.

## Required input

Set Terraform variable `vcs_provider_id` (e.g. `vcs-xxxxxxxx`) on this workspace.

Optional:
- `vcs_repo_identifier` (default `mshytse/base`)
- `vcs_branch` (default `master`)
- `name_prefix` (default `semver-sort`)
- `auto_queue_runs` (default `never` so create does not fan out 14 runs)
- `aws_provider_configuration_id` (`pcfg-...`) for `provider_aws_*` and `module_s3_*`

## Usage

1. Push fixtures + this bootstrap dir.
2. Create one workspace pointed at `config/reports/semver_sort_bootstrap` (or CLI from that path).
3. Set `vcs_provider_id` (and optional AWS pcfg).
4. Apply → 14 workspaces under current env, each with working_directory `config/reports/semver_sort/<fixture>`.
5. Queue runs on the fixture workspaces (or set `auto_queue_runs=always` and re-push).

`tofu_*` workspaces use `iac_platform = opentofu` and versions from Scalr's OpenTofu list (`>= 1.6.0`), not the Terraform list.

Fixture contents: `../semver_sort/README.md`.
