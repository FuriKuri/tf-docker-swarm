provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_droplet" "docker_swarm_node" {
  count = 5
  name = "${var.name_prefix}-docker-swarm-node-${count.index}"
  region = "${var.do_region}"
  size = "${var.do_droplet_size}"
  image = "${var.do_image}"
  ssh_keys = ["${var.ssh_fingerprint}"]

  provisioner "remote-exec" {
    script = "install-docker.sh"
    connection {
      type     = "ssh"
      user     = "root"
      private_key = "${file(var.ssh_private_key)}"
    }
  }
}