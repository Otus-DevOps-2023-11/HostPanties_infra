variable "cloud_id" {
  description = "Cloud ID"
}

variable "folder_id" {
  description = "Folder ID"
}

variable "zone" {
  description = "Name of the cloud zone"
  default     = "ru-central1-b"
}

variable "public_key_path" {
  description = "Path to public key"
}

variable "image_id" {
  description = "Image ID"
}

variable "subnet_id" {
  description = "Subnet ID"
}

variable "service_account_key_file" {
  description = "key .json"
}

variable "private_key_path" {
  description = "Private key path"
}

variable "app_disk_image" {
  description = "Reddit app baked disk image name"
  default = "reddit-app-1"
}

variable "db_disk_image" {
  description = "Reddit DB baked disk image name"
  default = "reddit-db-1"
}

variable access_key {
  type = string
}

variable secret_key {
  type = string
}

variable pub-key {
  type = string
}
