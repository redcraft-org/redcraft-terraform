# RedCraft terraform

Terraform files files defining the infrastructure of RedCraft. They are used to ensure consistency in the deployment of services.

## How to use

### Setup

First of, make sure to install [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) 0.13 or later.

Please notice that you'll need the following variables:

- scw_access_key
- scw_secret_key
- scw_default_organization_id
- scw_default_project_id
- scw_default_region
- scw_default_zone

If you use a `.scwrc` file, you can append the following to automatically use variables:

```bash
export TF_VAR_scw_access_key=$SCW_ACCESS_KEY
export TF_VAR_scw_secret_key=$SCW_SECRET_KEY
export TF_VAR_scw_default_organization_id=$SCW_DEFAULT_ORGANIZATION_ID
export TF_VAR_scw_default_project_id=$SCW_DEFAULT_PROJECT_ID
export TF_VAR_scw_default_region=$SCW_DEFAULT_REGION
export TF_VAR_scw_default_zone=$SCW_DEFAULT_ZONE
```

### Deploy infrastructure

Before deploying, make sure the server images are ready if necessary. These can be generated with [our Packer configuration](https://github.com/redcraft-org/redcraft_packer).

For each service, `cd` to `terraform/redcraft-<name>` and run the following commands:

- `../../init_bucket.sh`
- `terraform workspace select <environment>` or `terraform workspace new <environment>`
- `terraform plan -var-file=<environment>.tfvars`

If the plan sounds okay, run `terraform apply -var-file=<environment>.tfvars` and everything will deploy.
