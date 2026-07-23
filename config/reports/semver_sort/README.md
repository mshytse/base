# SCALRCORE-39212 - semver sort fixtures

Manual QA for [SCALRCORE-39212](https://scalr-labs.atlassian.net/browse/SCALRCORE-39212) / [fatmouse#12550](https://github.com/Scalr/fatmouse/pull/12550).

Bug: version columns sorted as strings (`4.4.0` after `4.32.0`). Fix joins the `versions` dictionary so sort is semantic.

## What to create

One Scalr workspace per subdirectory (VCS working directory = that path). Run plan+apply in each so usage reports pick up the pinned version.

**Provider usage (`hashicorp/time`) - no cloud creds**
- `provider_time_0_9_0` → `0.9.0`
- `provider_time_0_10_0` → `0.10.0`
- `provider_time_0_11_2` → `0.11.2`
- `provider_time_0_12_1` → `0.12.1`
- Lex (wrong): `0.10.0`, `0.11.2`, `0.12.1`, `0.9.0`
- Semver asc: `0.9.0`, `0.10.0`, `0.11.2`, `0.12.1`

**Provider usage (`hashicorp/aws`) - ticket repro, needs AWS pcfg**
- `provider_aws_4_4_0` → `4.4.0`
- `provider_aws_4_32_0` → `4.32.0`
- `provider_aws_4_52_7` → `4.52.7`
- Lex (wrong): `4.32.0`, `4.4.0`, `4.52.7`
- Semver asc: `4.4.0`, `4.32.0`, `4.52.7`

**Module usage (`cloudposse/label/null`)**
- `module_label_0_9_0` → `0.9.0`
- `module_label_0_10_0` → `0.10.0`
- `module_label_0_11_0` → `0.11.0`
- `module_label_0_25_0` → `0.25.0`
- Lex (wrong): `0.10.0`, `0.11.0`, `0.25.0`, `0.9.0`
- Semver asc: `0.9.0`, `0.10.0`, `0.11.0`, `0.25.0`

**Terraform version usage (`required_version`)**
- `terraform_1_4_6` → `1.4.6`
- `terraform_1_5_7` → `1.5.7`
- `terraform_1_9_0` → `1.9.0`
- `terraform_1_10_5` → `1.10.5`
- Lex (wrong): `1.10.5`, `1.4.6`, `1.5.7`, `1.9.0`
- Semver asc: `1.4.6`, `1.5.7`, `1.9.0`, `1.10.5`

Set each terraform_* workspace to the matching Terraform version in Scalr (or rely on `required_version`).

## Checks after applies

1. Reports → Provider usage → `hashicorp/time` (and `hashicorp/aws` if used) → sort version asc/desc.
2. Reports → Module usage → `cloudposse/label/null` → sort version.
3. Reports → Terraform versions → sort version.
4. Registry module/provider version lists + software versions (upload Terragrunt/OpenTofu builds with same digit-width clash; no TF files here).

Expected ascending for ticket pair: `4.4.0` before `4.32.0` before `4.52.7`.
