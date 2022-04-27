resource "yandex_kubernetes_cluster" "zonal_cluster_resource_name" {
  name = "k8s-cluster-zonal"
  network_id = var.default_network_id

  master {
    version = var.version_of_k8s_cluster
    zonal {
      zone      = var.default_zone
      subnet_id = var.default_subnet_id
    }

    public_ip = true

    maintenance_policy {
      auto_upgrade = true

      maintenance_window {
        start_time = "15:00"
        duration   = "3h"
      }
    }
  }

  service_account_id      = var.default_sa_id
  node_service_account_id = var.default_node_sa_id

  labels = {
    my_key       = "my_value"
    my_other_key = "my_other_value"
  }

  release_channel = var.release_channel
  // Use one block with Cilium or another with CALICO
  # network_implementation {
  #   cilium {}
  # }
  network_policy_provider = "CALICO"
}

resource "yandex_kubernetes_node_group" "my_node_group" {
  cluster_id  = "${yandex_kubernetes_cluster.zonal_cluster_resource_name.id}"
  name = "k8s-cluster-zonal-node-group"
  version     = var.version_of_k8s_cluster

  labels = {
    "key" = "value"
  }

  instance_template {
    platform_id = var.default_platform_id

    network_interface {
      nat                = true
      subnet_ids         = [var.default_subnet_id]
      security_group_ids = [yandex_vpc_security_group.security_group_2.id]
    }

    resources{
      memory = var.default_memory == "memory_with_gpu" ? var.default_having_memory["memory_with_gpu"] : var.default_having_memory["memory_with_no_gpu"] // 119 or 2
      cores  = var.default_cores == "cores_with_gpu" ? var.default_having_cores["cores_with_gpu"] : var.default_having_cores["cores_with_no_gpu"] // 28 or 2
      core_fraction = var.environment == "prod" ? var.default_having_core_fraction["prod"] : var.default_having_core_fraction["test"] // 100 or 50
      gpus = var.default_gpu == "gpu" ? var.default_having_gpu["gpu"] : var.default_having_gpu["no_gpu"] // 1 or 0
    }

    boot_disk {
      type = var.default_type 
      size = var.default_type != "network-ssd-nonreplicated" ? var.default_having_size["size_hdd_or_ssd"] : var.default_having_size["size_nrd"] // 64 or 93
    }

    scheduling_policy {
      preemptible = false
    }

    container_runtime {
      type = var.container_runtime //docker or containerd
    }
  }

  scale_policy {
    auto_scale {
      min = 1
      max = 2
      initial = 1
    }
  }

  allocation_policy {
    location {
      zone = var.default_zone
    }
  }

  maintenance_policy {
    auto_upgrade = true
    auto_repair  = true

    maintenance_window {
      day        = "monday"
      start_time = "15:00"
      duration   = "3h"
    }

    maintenance_window {
      day        = "friday"
      start_time = "10:00"
      duration   = "4h30m"
    }
  }
}