output "public_ip" {
  value = "${join(", ",digitalocean_droplet.docker_swarm_node.*.ipv4_address)}"
}