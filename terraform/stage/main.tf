provider "yandex" {
  service_account_key_file = file(var.service_account_key_file)
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

module "app" {
  source            = "../modules/app"
  name              = "reddit-app-stage"
  public_key_path   = var.public_key_path
  app_disk_image    = var.app_disk_image
  subnet_id         = var.subnet_id
  db_ext_ip         = module.db.external_ip_address_db
  puma-service-file = "../files/puma.service"
  deploy-file       = "../files/deploy.sh"
  pub-key           = var.pub-key
  env               = "stage"
}

module "db" {
  source          = "../modules/db"
  name            = "reddit-db-stage"
  public_key_path = var.public_key_path
  db_disk_image   = var.db_disk_image
  subnet_id       = var.subnet_id
  pub-key         = var.pub-key
  env             = "stage"
}
