resource "google_artifact_registry_repository" "my-repo" {
  location      = var.region
  repository_id = "container-dev-repo"
  description   = "Docker repository for Container Dev Workshop"
  format        = "DOCKER"
}

resource "google_service_account" "sa" {
  account_id   = "cloud-ws"
  display_name = "A service account used for Cloud workstation"
}

resource "google_project_iam_binding" "project" {
  project = var.project_id
  role    = "roles/editor"

  members = [
    "serviceAccount:${google_service_account.sa.email}",
  ]
}
