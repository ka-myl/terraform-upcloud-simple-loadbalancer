terraform {
  required_providers {
    upcloud = {
      source  = "UpCloudLtd/upcloud"
      version = "~> 2.4"
    }
  }
}

resource "upcloud_loadbalancer" "lb" {
  configured_status = "started"
  name              = "${var.name_prefix}_loadbalancer"
  plan              = var.plan
  zone              = var.zone
  network           = var.network_id
}

resource "upcloud_loadbalancer_backend" "backend" {
  loadbalancer = upcloud_loadbalancer.lb.id
  name         = "${var.name_prefix}_backend"
}

resource "upcloud_loadbalancer_static_backend_member" "backend_member" {
  count        = length(var.servers_ips)
  backend      = upcloud_loadbalancer_backend.backend.id
  name         = "${var.name_prefix}_backend_member_${count.index}"
  ip           = var.servers_ips[count.index]
  port         = var.server_port
  weight       = 100
  max_sessions = 1000
  enabled      = true
}

resource "upcloud_loadbalancer_frontend" "frontend" {
  loadbalancer         = upcloud_loadbalancer.lb.id
  name                 = "${var.name_prefix}_frontend"
  mode                 = "http"
  port                 = var.frontend_port
  default_backend_name = upcloud_loadbalancer_backend.backend.name
}
