terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.13"
}

provider "yandex" {
  service_account_key_file = file(var.service_account_key_file)
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

module "app" {
  source          = "../modules/app"
  name            = "reddit-app-prod"
  db_ext_ip       = module.db.external_ip_address_db
  public_key_path = var.public_key_path
  app_disk_image  = var.app_disk_image
  subnet_id       = var.subnet_id
  puma-service-file = "../files/puma.service"
  deploy-file     = "../files/deploy.sh"
}

module "db" {
  source          = "../modules/db"
  name            = "reddit-db-prod"
  public_key_path = var.public_key_path
  db_disk_image   = var.db_disk_image
  subnet_id       = var.subnet_id

}
