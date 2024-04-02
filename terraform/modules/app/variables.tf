variable public_key_path {
  description = "Path to public key used for ssh access"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default = "reddit-app-1"
}

variable subnet_id {
  description = "Subnets for modules"
}

variable name {
  type = string
}

variable db_ext_ip {
  description = "External IP address of database instance"
}

variable puma-service-file {
  type = string
}

variable deploy-file {
  type = string
}
