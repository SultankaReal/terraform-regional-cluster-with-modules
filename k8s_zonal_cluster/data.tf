data "yandex_kubernetes_cluster" "zonal_cluster_resource_name" {
  cluster_id = yandex_kubernetes_cluster.zonal_cluster_resource_name.id
}
