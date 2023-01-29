module "project-services" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  project_id  = var.project_id
  disable_services_on_destroy = false
  activate_apis = [
    "anthos.googleapis.com",
    "artifactregistry.googleapis.com",
    "cloudbuild.googleapis.com",
    "cloudscheduler.googleapis.com",
    "clouddebugger.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "clouderrorreporting.googleapis.com",
    "cloudtrace.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com",
    "containerscanning.googleapis.com",
    "dns.googleapis.com",
    "gkeconnect.googleapis.com",
    "gkehub.googleapis.com",
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "logging.googleapis.com",
    "meshca.googleapis.com",
    "meshtelemetry.googleapis.com",
    "meshconfig.googleapis.com",
    "monitoring.googleapis.com",
    "ondemandscanning.googleapis.com",
    "privateca.googleapis.com",
    "secretmanager.googleapis.com",
    "stackdriver.googleapis.com",
    "workstations.googleapis.com"
  ]
}

