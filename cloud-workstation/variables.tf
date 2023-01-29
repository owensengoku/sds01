variable "project_id" {
  type = string
  default = "shawn-demo-2023"
}

variable "region" {
    type = string
    default = "us-central1"
}

variable "zone" {
    type = string
    default = "us-central1-a"
}

variable "vpc_common" {
  type = string
  default = "common"
}

variable "vpc_intranet" {
    type = string
    default = "intranet"
}

variable "vpc_onprem" {
  type = string
  default = "onprem"
}

variable "google_private_ips" {
  description = "Private Google API IPs see: https://cloud.google.com/vpc/docs/configure-private-google-access"
  default = ["199.36.153.8", "199.36.153.9", "199.36.153.10", "199.36.153.11"]
}

variable "gcp_ip_ranges" {
    default = ["10.1.0.0/24", "10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
}

variable "onprem_ip_ranges" {
    default = ["192.168.0.0/24", "192.168.1.0/24"]
}

variable "google_private_ip_cidr" {
  description = "Private Google API IP CIDR see: https://cloud.google.com/vpc/docs/configure-private-google-access"
  default = "199.36.153.8/30"
}

variable "windows_2019_sku" {
  type        = string
  description = "SKU for Windows Server 2019"
  default     = "windows-cloud/windows-2019"
}

variable "windows_instance_type" {
  type        = string
  description = "VM instance type for Windows Server"
  default     = "n2-standard-2"
}

variable "vm_type" {
  type        = string
  description = "GKE Workload Type"
  default     = "n1-standard-8"
}

variable "cluster_name" {
  description = "cluster name used in the lab"
  default     = "sds-cluster"
}

variable "zones" {
  description = "The primary zones to be used"
  default = ["us-central1-a", "us-central1-b", "us-central1-c"]
}