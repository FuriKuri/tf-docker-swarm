variable "count" {
  description = "Number of instances"
  default = 2
}

variable "do_token" {
  description = "Your Digital Ocean API token"
}

variable "ssh_fingerprint" {
  description = "Your SSH fingerprint"
}

variable "name_prefix" {
  description = "Name prefix"
}

variable "ssh_private_key" {
  description = "Your SSH private key"
}

variable "do_region" {
  description = "The region slug to launch the Digital Ocean droplets in"
  default = "fra1"
}

variable "do_droplet_size" {
  description = "The size droplets to use for the manager and worker nodes"
  default = "2gb"
}

variable "do_image" {
  description = "The image to use to initialize the droplets"
  default = "ubuntu-16-04-x64"
}