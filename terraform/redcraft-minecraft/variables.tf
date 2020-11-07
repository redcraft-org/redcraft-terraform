variable "scw_access_key" {
  description = "SCW_ACCESS_KEY environment variable"
}

variable "scw_secret_key" {
  description = "SCW_SECRET_KEY environment variable"
}

variable "scw_default_organization_id" {
  description = "SCW_DEFAULT_ORGANIZATION_ID environment variable"
}

variable "scw_default_region" {
  description = "SCW_DEFAULT_REGION environment variable"
}

variable "scw_default_zone" {
  description = "SCW_DEFAULT_ZONE environment variable"
}

# Defined on a per environment basis in *.tfvars
variable "env_name" {
}

variable "instance_type" {
    default = "DEV1-L"
}

variable "attached_disk_size" {
    default = 80
}
