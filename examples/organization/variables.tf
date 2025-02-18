# Mandatory vars
variable "sysdig_secure_api_token" {
  type        = string
  description = "Sysdig's Secure API Token"
}

variable "organization_domain" {
  type        = string
  description = "Organization domain. e.g. sysdig.com"
}

# --------------------------
# optionals, with defaults
# --------------------------
variable "sysdig_secure_endpoint" {
  type        = string
  default     = "https://secure.sysdig.com"
  description = "Sysdig Secure API endpoint"
}

variable "name" {
  type        = string
  description = "Name to be assigned to all child resources. A suffix may be added internally when required. Use default value unless you need to install multiple instances"
  default     = "sfc"

  validation {
    condition     = can(regex("^[a-z0-9]+$", var.name))
    error_message = "ERROR: Invalid name. must contain only lowercase letters (a-z) and numbers (0-9)."
  }
}

variable "max_instances" {
  type        = number
  description = "Max number of instances for the workloads"
  default     = 1
}


# scanning

variable "repository_project_ids" {
  default     = []
  type        = list(string)
  description = "Projects were a `gcr`-named topic will be to subscribe to its repository events. If empty, all organization projects will be defaulted."
}

# benchmark

variable "deploy_bench" {
  type        = bool
  description = "whether benchmark module is to be deployed"
  default     = true
}

variable "benchmark_regions" {
  type        = list(string)
  description = "List of regions in which to run the benchmark. If empty, the task will contain all regions by default."
  default     = []
}

variable "benchmark_project_ids" {
  default     = []
  type        = list(string)
  description = "Google cloud project IDs to run Benchmarks on. If empty, all organization projects will be defaulted."
}

variable "benchmark_role_name" {
  type        = string
  description = "The name of the Service Account that will be created."
  default     = "sysdigcloudbench"
}
