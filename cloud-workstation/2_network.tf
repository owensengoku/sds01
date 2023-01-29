resource "google_compute_network" "network3" {
  name                    = var.vpc_intranet
  routing_mode            = "GLOBAL"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "network3_subnet1" {
  name          = "${var.vpc_intranet}-subnet1"
  ip_cidr_range = "10.1.2.0/24"
  region        = var.region
  network       = google_compute_network.network3.id
  secondary_ip_range {
    ip_cidr_range = "10.1.8.0/21"
    range_name = "pod-range"
  }
  secondary_ip_range {
    ip_cidr_range = "10.1.16.0/23"
    range_name = "svc-range"
  }
}

resource "google_compute_subnetwork" "network3_subnet2" {
  name          = "${var.vpc_intranet}-subnet2"
  ip_cidr_range = "10.1.3.0/24"
  region        = var.region
  network       = google_compute_network.network3.id
}

resource "google_compute_router" "nat-router3" {
  name    = "${var.vpc_intranet}-router1"
  network = google_compute_network.network3.name
  region  = google_compute_subnetwork.network3_subnet2.region
}

resource "google_compute_router_nat" "nat" {
  name                               = "intranet-snat"
  router                             = google_compute_router.nat-router3.name
  region                             = google_compute_router.nat-router3.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}