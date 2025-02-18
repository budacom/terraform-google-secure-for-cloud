# Sysdig Secure for Cloud in GCP<br/>[ Example :: Organization ]

This example deploys Secure for Cloud into a GCP organizational account.

Sysdig workload will be deployed in the `project_id` defined in the required input parameter.

![single project diagram](https://github.com/sysdiglabs/terraform-google-secure-for-cloud/blob/master/examples/organization/diagram-org.png?raw=true)

## Prerequisites

1. Configure [Terraform **GCP** Provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs)
2. Following **roles** are required in your GCP organization/project credentials
   * _Owner_
   * _Organization Admin_
3. Besides, the following GCP **APIs must be enabled** to deploy resources correctly for:

### Cloud Connector

* [Cloud Pub/Sub API](https://console.cloud.google.com/marketplace/product/google/pubsub.googleapis.com)
* [Cloud Run API](https://console.cloud.google.com/marketplace/product/google/run.googleapis.com)
* [Eventarc API](https://console.cloud.google.com/marketplace/product/google/eventarc.googleapis.com)

### Cloud Scanning

* [Cloud Pub/Sub API](https://console.cloud.google.com/marketplace/product/google/pubsub.googleapis.com)
* [Cloud Run API](https://console.cloud.google.com/marketplace/product/google/run.googleapis.com)
* [Eventarc API](https://console.cloud.google.com/marketplace/product/google/eventarc.googleapis.com)
* [Secret Manger API](https://console.cloud.google.com/marketplace/product/google/secretmanager.googleapis.com)
* [Cloud Build API](https://console.cloud.google.com/marketplace/product/google/cloudbuild.googleapis.com)
* [Identity and access management API](https://console.cloud.google.com/marketplace/product/google/iam.googleapis.com)

### Cloud Benchmarks

* [Identity and access management API](https://console.cloud.google.com/marketplace/product/google/iam.googleapis.com)
* [IAM Service Account Credentials API](https://console.cloud.google.com/marketplace/product/google/iamcredentials.googleapis.com)
* [Cloud Resource Manager API](https://console.cloud.google.com/marketplace/product/google/cloudresourcemanager.googleapis.com)
* [Security Token Service API](https://console.cloud.google.com/marketplace/product/google/sts.googleapis.com)

## Usage

For quick testing, use this snippet on your terraform files

```terraform
provider "google" {
   project = "<PROJECT_ID>"
   region  = "<REGION_ID>; ex. us-central-1"
}

module "secure-for-cloud_example_organization" {
  source = "sysdiglabs/secure-for-cloud/google//examples/organization"

  repository_project_ids    = ["<PROJECT_SCAN_ID1>", "<PROJECT_SCAN_ID2>"]
   sysdig_secure_url         = "<SYSDIG_SECURE_URL>"
   sysdig_secure_endpoint    = "<SYSDIG_SECURE_API_TOKEN>"
  organization_domain       = "<ORG_DOMAIN>"
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 3.67.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | ~> 3.67.0 |
| <a name="requirement_sysdig"></a> [sysdig](#requirement\_sysdig) | >= 0.5.21 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 3.67.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloud_bench"></a> [cloud\_bench](#module\_cloud\_bench) | ../../modules/services/cloud-bench | n/a |
| <a name="module_cloud_connector"></a> [cloud\_connector](#module\_cloud\_connector) | ../../modules/services/cloud-connector | n/a |
| <a name="module_connector_organization_sink"></a> [connector\_organization\_sink](#module\_connector\_organization\_sink) | ../../modules/infrastructure/organization_sink | n/a |
| <a name="module_pubsub_http_subscription"></a> [pubsub\_http\_subscription](#module\_pubsub\_http\_subscription) | ../../modules/infrastructure/pubsub_push_http_subscription | n/a |
| <a name="module_secure_secrets"></a> [secure\_secrets](#module\_secure\_secrets) | ../../modules/infrastructure/secrets | n/a |

## Resources

| Name | Type |
|------|------|
| [google_organization_iam_custom_role.org_gcr_image_puller](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_custom_role) | resource |
| [google_organization_iam_member.organization_image_puller](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_member) | resource |
| [google_service_account.connector_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_client_config.current](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |
| [google_organization.org](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/organization) | data source |
| [google_projects.all_projects](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/projects) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_organization_domain"></a> [organization\_domain](#input\_organization\_domain) | Organization domain. e.g. sysdig.com | `string` | n/a | yes |
| <a name="input_sysdig_secure_api_token"></a> [sysdig\_secure\_api\_token](#input\_sysdig\_secure\_api\_token) | Sysdig's Secure API Token | `string` | n/a | yes |
| <a name="input_benchmark_project_ids"></a> [benchmark\_project\_ids](#input\_benchmark\_project\_ids) | Google cloud project IDs to run Benchmarks on. If empty, all organization projects will be defaulted. | `list(string)` | `[]` | no |
| <a name="input_benchmark_regions"></a> [benchmark\_regions](#input\_benchmark\_regions) | List of regions in which to run the benchmark. If empty, the task will contain all regions by default. | `list(string)` | `[]` | no |
| <a name="input_benchmark_role_name"></a> [benchmark\_role\_name](#input\_benchmark\_role\_name) | The name of the Service Account that will be created. | `string` | `"sysdigcloudbench"` | no |
| <a name="input_deploy_bench"></a> [deploy\_bench](#input\_deploy\_bench) | whether benchmark module is to be deployed | `bool` | `true` | no |
| <a name="input_max_instances"></a> [max\_instances](#input\_max\_instances) | Max number of instances for the workloads | `number` | `1` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to be assigned to all child resources. A suffix may be added internally when required. Use default value unless you need to install multiple instances | `string` | `"sfc"` | no |
| <a name="input_repository_project_ids"></a> [repository\_project\_ids](#input\_repository\_project\_ids) | Projects were a `gcr`-named topic will be to subscribe to its repository events. If empty, all organization projects will be defaulted. | `list(string)` | `[]` | no |
| <a name="input_sysdig_secure_endpoint"></a> [sysdig\_secure\_endpoint](#input\_sysdig\_secure\_endpoint) | Sysdig Secure API endpoint | `string` | `"https://secure.sysdig.com"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Module is maintained and supported by [Sysdig](https://github.com/sysdiglabs/terraform-google-cloudvision).

## License

Apache 2 Licensed. See LICENSE for full details.
