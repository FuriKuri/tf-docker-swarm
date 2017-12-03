output "public_ip" {
  value = "${join(", ",digitalocean_droplet.docker_swarm_node.*.ipv4_address)}"
}

output "public_dns" {
  value = "${join(", ",digitalocean_domain.docker_swarm_node.*.name)}"
}