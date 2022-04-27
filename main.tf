# Create k8s regional cluster with node group
module "k8s_module" {
  source = "./k8s_regional_cluster" //the source of the module
  default_zone = "ru-central1-b" //ru-central1-a, ru-central1-b or ru-central1-c
  version_of_k8s_cluster = "1.21" //1.18, 1.19, 1.20 or 1.21
  release_channel = "STABLE" //RAPID, REGULAR or STABLE
  default_platform_id = "standard-v2" // standard-v1, standard-v2, standard-v3, gpu-standard-v1, gpu-standard-v2, gpu-standard-v3, standard-v3-t4, vgpu-standard-v1
  container_runtime = "docker" //docker or containerd
}

# Create k8s zonal cluster with node group
module "k8s_module_zonal" {
  source = "./k8s_zonal_cluster" //the source of the module
  default_zone = "ru-central1-b" //ru-central1-a, ru-central1-b or ru-central1-c
  version_of_k8s_cluster = "1.21" //1.18, 1.19, 1.20 or 1.21
  release_channel = "STABLE" //RAPID, REGULAR or STABLE
  default_platform_id = "standard-v1" // standard-v1, standard-v2, standard-v3, gpu-standard-v1, gpu-standard-v2, gpu-standard-v3, standard-v3-t4, vgpu-standard-v1
  container_runtime = "docker" //docker or containerd
}

