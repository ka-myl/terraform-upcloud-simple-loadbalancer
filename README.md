# Terraform UpCloud Simple Loadbalancer

This module creates a simple load balancer setup with all the basic pieces.

Example usage:

```
resource "upcloud_network" "sdn" {
  name = "lb-test-sdn"
  zone = "pl-waw1"

  ip_network {
    address = "10.0.20.0/24"
    dhcp    = true
    family  = "IPv4"
  }
}

resource "upcloud_server" "servers" {
  count    = 3
  hostname = "lb-test-${count.index}"
  zone     = "pl-waw1"
  plan     = "1xCPU-1GB"

  template {
    storage = data.upcloud_storage.app_image.id
    size    = 25
  }

  network_interface {
    type = "utility"
  }

  network_interface {
    type = "public"
  }

  network_interface {
    type    = "private"
    network = upcloud_network.sdn.id
  }
}

module "lb" {
  source = "./basic_loadbalancer"

  name_prefix = "xyz"
  zone = "pl-waw1"
  network_id = upcloud_network.sdn.id
  servers_ips = [for v in upcloud_server.servers: v.network_interface.2.ip_address]
  server_port = 3000
}
```
