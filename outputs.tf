output "service_id" {
  value = upcloud_loadbalancer.lb.id
}

output "backend_id" {
  value = upcloud_loadbalancer_backend.backend.id
}

output "backend_name" {
  value = upcloud_loadbalancer_backend.backend.name
}

output "frontend_id" {
  value = upcloud_loadbalancer_frontend.frontend.id
}

output "frontend_name" {
  value = upcloud_loadbalancer_frontend.frontend.id
}

output "dns_name" {
  value = upcloud_loadbalancer.lb.dns_name
}
