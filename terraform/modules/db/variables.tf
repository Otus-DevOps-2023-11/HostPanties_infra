variable public_key_path {
  description = "Path to public key used for ssh access"
}

variable db_disk_image {
  description = "Disk image for reddit db"
  default = "reddit-db-1"
}

variable subnet_id {
  description = "Subnets for modules"
}

variable name {
  type = string
}

variable pub-key {
  type = string
}

variable env {
  description = "Environment of vm i.e. prod or stage"
  type = string
}
