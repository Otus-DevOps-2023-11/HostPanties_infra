terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.13"
}

provider "yandex" {
  token     = "y0_AgAAAAB0OuFmAATuwQAAAAD7dxLKAACIusC6FVxI6Kky26ubualyP2rdPw"
  cloud_id  = "b1g2a34319jmp1basb38"
  folder_id = "b1gu9td5uk8ohab1ecp8"
  zone      = "ru-central1-b"
}

resource "yandex_compute_instance" "app" {
  name = "reddit-app"
  
  resources {
    core   = "2"
    memory = "2"
  }
  boot_disk {
    initialize_params {
      image_id = "fd88b7pbagov3l9sg8mh"
    }
  }
  network-interface {
    subnet_id = "enpfmrrs6tdubo6sqf25"
    nat       = true
  }
}

