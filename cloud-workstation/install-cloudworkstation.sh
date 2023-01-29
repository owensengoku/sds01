#!/bin/bash
function __main__ () {
  echo "[$DATE] Init script running"
  __print_separator__
  __gen_workstation_config__
  __print_separator__
  __enable_workstation_config__
  __print_separator__
  __gen_template_config__
  __print_separator__
  __create_template__
  echo "[+] Successfully completed initialization"
}

function __gen_workstation_config__ () {
cat << EOF > cluster.json
{
  "network": "projects/${PROJECT}/global/networks/${NETWORK}",
  "subnetwork": "projects/${PROJECT}/regions/${REGION}/subnetworks/${NETWORK}-subnet2"
}
EOF
}

function __enable_workstation_config__ () {
  curl -H "Authorization: Bearer $(gcloud auth print-access-token)" \
  -H "Content-Type: application/json" \
  -d @cluster.json \
  "https://workstations.googleapis.com/v1beta/projects/${PROJECT}/locations/${REGION}/workstationClusters?workstation_cluster_id=my-cluster"

  while true; do 
    result=$(curl -H "Authorization: Bearer $(gcloud auth print-access-token)" \
  -H "Content-Type: application/json" \
  "https://workstations.googleapis.com/v1beta/projects/${PROJECT}/locations/${REGION}/workstationClusters/my-cluster" | jq .reconciling)
    if [[ $result == "true" ]]; then
      echo "Still provisioning"
      sleep 10
    else
      echo "Workstation is provisioned"
      break
    fi
  done
}

function __gen_template_config__ () {
cat << EOF > ./myconfig-gnome.json
{
  "idleTimeout": "7200s",
  "host": {
    "gce_instance": {
      "machine_type": "e2-standard-4",
      "pool_size": 1,
      "service_account": "cloud-ws@${PROJECT}.iam.gserviceaccount.com",
      "disable_public_ip_addresses": true
    }
  },
  "persistentDirectories": [
    {
      "mountPath": "/home",
      "gcePd": {
        "sizeGb": 200,
        "fsType": "ext4"
      }
    }
  ],
  "container": {
    "image": "us-central1-docker.pkg.dev/cloud-workstations-images/predefined/code-oss:latest"
  }
}
EOF
}

function __create_template__ () {
  config_name="myconfig-gnome"

  curl -H "Authorization: Bearer $(gcloud auth print-access-token)" \
      -H "Content-Type: application/json" \
      -d @${config_name}.json \
  "https://workstations.googleapis.com/v1beta/projects/${PROJECT}/locations/${REGION}/workstationClusters/my-cluster/workstationConfigs?workstation_config_id=${config_name}"

  while true; do 
    result=$(curl -H "Authorization: Bearer $(gcloud auth print-access-token)" \
    -H "Content-Type: application/json" \
    "https://workstations.googleapis.com/v1beta/projects/${PROJECT}/locations/${REGION}/workstationClusters/my-cluster/workstationConfigs/${config_name}" | jq .reconciling)
    if [[ $result == "true" ]]; then
      echo "Still provisioning"
      sleep 10
    else
      echo "Cluster is provisioned"
      break
    fi
  done
}

function __print_separator__ () {
  echo "------------------------------------------------------------------------------"
  sleep 5
}

# Run the script from main()
__main__ "$@" 