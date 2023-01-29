resource "google_compute_firewall" "deny_all_egress" {
    name    = "intranet-deny-egress"
    network = google_compute_network.network3.self_link

    direction = "EGRESS"
    priority = 9999

    deny {
    protocol = "all"
    }
    destination_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow-egress" {
    name    = "intranet-allow-egress"
    network = google_compute_network.network3.self_link
    direction = "EGRESS"
    priority = 1000

    allow {
        protocol = "tcp"
    }
    allow {
    protocol = "icmp"
    }
    destination_ranges = ["0.0.0.0/0"]
}
resource "google_compute_firewall" "allow-google-private-egress" {
    name    = "intranet-allow-google-private-egress"
    network = google_compute_network.network3.self_link 
 
    direction = "EGRESS"
    priority = 1000

    allow {
    protocol = "tcp"
    ports = ["443"]
    }
    destination_ranges = [var.google_private_ip_cidr]
}

resource "google_compute_firewall" "allow-internal-egress-intranet" {
 name    = "intranet-allow-internal-egress"
 network = google_compute_network.network3.self_link

 direction = "EGRESS"
 priority = 1000

 allow {
    protocol = "all"
 }
 destination_ranges = var.gcp_ip_ranges
}