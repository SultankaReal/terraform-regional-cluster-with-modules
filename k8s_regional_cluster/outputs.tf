output "version_info" {
  value = "${yandex_kubernetes_cluster.regional_cluster_resource_name.master.0.version}"
  description = "Information about cluster version"
}

output "public_ip_of_k8s_cluster_master" {
  value = "${yandex_kubernetes_cluster.regional_cluster_resource_name.master.0.external_v4_address}"
  description = "The public ip of k8s cluster (master)"
}

output "cluster_k8s_status" {
  value = "${data.yandex_kubernetes_cluster.regional_cluster_resource_name.status}"
  description = "Status of k8s cluster"
}

output "cluster_k8s_health" {
  value = "${data.yandex_kubernetes_cluster.regional_cluster_resource_name.health}"
  description = "Health of the k8s cluster"
}

output "cluster_k8s_created_at" {
  value = "${data.yandex_kubernetes_cluster.regional_cluster_resource_name.created_at}"
  description = "When did the k8s cluster create at?"
}

output "cluster_k8s_release_channel" {
  value = "${data.yandex_kubernetes_cluster.regional_cluster_resource_name.release_channel}"
  description = "The release channel of the k8s cluster"
}

output "cluster_k8s_network_policy_provider" {
  value = "${data.yandex_kubernetes_cluster.regional_cluster_resource_name.network_policy_provider}"
  description = "Network policy provider of the k8s cluster"
}

output "how_to_connect_to_k8s_cluster" {
  value = "yc managed-kubernetes cluster get-credentials --id ${data.yandex_kubernetes_cluster.regional_cluster_resource_name.id} --external --force"
  description = "How to connect to k8s cluster"
}
