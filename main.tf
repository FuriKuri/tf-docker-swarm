provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_droplet" "docker_swarm_node" {
  count = "${var.count}"
  name = "${var.name_prefix}-docker-swarm-node-${count.index}"
  region = "${var.do_region}"
  size = "${var.do_droplet_size}"
  image = "${var.do_image}"
  ssh_keys = ["${var.ssh_fingerprint}"]

  provisioner "file" {
    source      = "install-docker.sh"
    destination = "/root/install-docker.sh"

    connection {
      type     = "ssh"
      user     = "root"
      private_key = "${file(var.ssh_private_key)}"
    }
  }

  provisioner "file" {
    source      = "create-host-aliases.sh"
    destination = "/root/create-host-aliases.sh"

    connection {
      type     = "ssh"
      user     = "root"
      private_key = "${file(var.ssh_private_key)}"
    }
  }

  provisioner "file" {
    source      = "${var.ssh_private_key}"
    destination = "/root/.ssh/id_rsa"

    connection {
      type     = "ssh"
      user     = "root"
      private_key = "${file(var.ssh_private_key)}"
    }
  }

  provisioner "remote-exec" {
    inline = [
        "chmod 0600 /root/.ssh/id_rsa",
        "chmod +x /root/create-host-aliases.sh",
        "/root/create-host-aliases.sh ${var.count} ${var.name_prefix}",
        "chmod +x /root/install-docker.sh",
        "/root/install-docker.sh"
    ]

    connection {
      type     = "ssh"
      user     = "root"
      private_key = "${file(var.ssh_private_key)}"
    }
  }
}

resource "digitalocean_domain" "docker_swarm_node" {
  count       = "${var.count}"
  name        = "${var.name_prefix}-docker-swarm-node-${count.index}.furikuri.net"
  ip_address  = "${element(digitalocean_droplet.docker_swarm_node.*.ipv4_address, count.index)}"
}