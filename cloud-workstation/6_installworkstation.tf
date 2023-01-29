resource "null_resource" "cloud-workstation" {
    triggers = {
        project_id = var.project_id
        region = var.region
        vpc_name = google_compute_network.network3.name
    }
    provisioner "local-exec" {
        command = "${path.module}/install-cloudworkstation.sh"
        environment = {
            PROJECT = var.project_id
            REGION = var.region
            NETWORK = "${google_compute_network.network3.name}"
        }
    }
}