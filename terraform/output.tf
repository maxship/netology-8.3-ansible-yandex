output "external_ip_el" {
  value = yandex_compute_instance.el.network_interface.0.nat_ip_address
}

output "external_ip_kib" {
  value = yandex_compute_instance.kib.network_interface.0.nat_ip_address
}

output "external_ip_app" {
  value = yandex_compute_instance.app.network_interface.0.nat_ip_address
}