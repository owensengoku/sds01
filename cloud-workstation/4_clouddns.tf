## DNS
resource "google_dns_managed_zone" "googleapis" {
  name     = "googleapis"
  dns_name = "googleapis.com."
  visibility = "private"
  project    = var.project_id
  private_visibility_config {
    networks {
      network_url = google_compute_network.network3.id
    }
  }
}

resource "google_dns_record_set" "googleapis-a" {
  name         = "private.googleapis.com."
  managed_zone = google_dns_managed_zone.googleapis.name
  project      = var.project_id
  type         = "A"
  ttl          = 60

  rrdatas = var.google_private_ips
}

resource "google_dns_record_set" "googleapis-cname" {
  name         = "*.googleapis.com."
  managed_zone = google_dns_managed_zone.googleapis.name
  project      = var.project_id
  type         = "CNAME"
  ttl          = 60

  rrdatas = ["private.googleapis.com."]
}

resource "google_dns_managed_zone" "gcr" {
  name     = "gcr"
  dns_name = "gcr.io."
  visibility = "private"
  project    = var.project_id
  private_visibility_config {
    networks {
      network_url = google_compute_network.network3.id
    }
  }
}

resource "google_dns_record_set" "gcr-a" {
  name         = "gcr.io."
  managed_zone = google_dns_managed_zone.gcr.name
  project      = var.project_id
  type         = "A"
  ttl          = 6

  rrdatas = var.google_private_ips
}

resource "google_dns_record_set" "gcr-cname" {
  name         = "*.gcr.io."
  managed_zone = google_dns_managed_zone.gcr.name
  project      = var.project_id
  type         = "CNAME"
  ttl          = 60

  rrdatas = ["gcr.io."]
}

resource "google_dns_managed_zone" "pkg" {
  name     = "pkg"
  dns_name = "pkg.dev."
  visibility = "private"
  project    = var.project_id
  private_visibility_config {
    networks {
      network_url = google_compute_network.network3.id
    }
  }
}

resource "google_dns_record_set" "pkg-a" {
  name         = "pkg.dev."
  managed_zone = google_dns_managed_zone.pkg.name
  project      = var.project_id
  type         = "A"
  ttl          = 60
  rrdatas = var.google_private_ips
}

resource "google_dns_record_set" "pkg-cname" {
  name         = "*.pkg.dev."
  managed_zone = google_dns_managed_zone.pkg.name
  project      = var.project_id
  type         = "CNAME"
  ttl          = 60

  rrdatas = ["pkg.dev."]
}