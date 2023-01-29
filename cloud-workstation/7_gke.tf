module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google"
  project_id                 = var.project_id
  name                       = var.cluster_name
  region                     = var.region
  zones                      = var.zones
  network                    = google_compute_network.network3.name
  subnetwork                 = google_compute_subnetwork.network3_subnet1.name
  ip_range_pods              = "pod-range"
  ip_range_services          = "svc-range"
  http_load_balancing        = true
  horizontal_pod_autoscaling = true
  filestore_csi_driver       = true
  datapath_provider          = "ADVANCED_DATAPATH"
  enable_binary_authorization = true
  enable_shielded_nodes      = true
  enable_cost_allocation     = false
  grant_registry_access      = true
  release_channel            = "REGULAR"
  monitoring_service         = "none"
  node_pools = [
    {
      name                      = "default-node-pool"
      machine_type              = var.vm_type
      min_count                 = 1
      max_count                 = 3
      local_ssd_count           = 0
      spot                      = false
      disk_size_gb              = 100
      disk_type                 = "pd-standard"
      image_type                = "COS_CONTAINERD"
      enable_gcfs               = false
      enable_gvnic              = false
      auto_repair               = true
      auto_upgrade              = true
      preemptible               = false
      initial_node_count        = 1
    }
  ]
  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  node_pools_labels = {
    all = {}
    default-node-pool = {
      default-node-pool = true
      #spot-instance     = true
    }
  }

  node_pools_metadata = {
    all = {}
    default-node-pool = {
      node-pool-metadata-custom-value = "default-node-pool"
    }
  }

  node_pools_taints = {
    all = []

    default-node-pool = [
      {
        key    = "default-node-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }

  node_pools_tags = {
    all = []

    default-node-pool = [
      "default-node-pool",
    ]
  }
}

module "fleet" {
  source     = "terraform-google-modules/kubernetes-engine/google//modules/fleet-membership"
  project_id = var.project_id
  location   = module.gke.location
  cluster_name     = module.gke.name
}