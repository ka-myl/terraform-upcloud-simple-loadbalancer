variable "name_prefix" {
  type = string
  description = "Prefix used to name all of the resources created by this module"
}

variable "plan" {
  type = string
  description = "Load balancer service plan"
  default = "development"
}

variable "zone" {
  type = string
  description = "Zone in which the load balancer service runs. Must be the same as private network and servers"
}

variable "network_id" {
  type = string
  description = "ID of the private network that will be used for load balancing"
}

variable "servers_ips" {
  type = list(string)
  description = "List of servers IP addresses. The traffic will be distributed across the servers listed here"
}

variable "server_port" {
  type = number
  description = "Port to which the load balancer should direct traffic for specific server"
}

variable "frontend_port" {
  type = number
  description = "Port on which the load balancer service will accept requests"
  default = 80
}
