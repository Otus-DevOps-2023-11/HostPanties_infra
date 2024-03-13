resource "yandex_lb_target_group" "app-lb-tg" {
  name = "app-lb-tg-01"
  region_id = "ru-central1"
 
  dynamic "target" {
    for_each = yandex_compute_instance.app 
    content {
      subnet_id = "${var.subnet_id}"
      address = target.value.network_interface.0.ip_address
    }
  }
/*
  target {
    subnet_id = "${var.subnet_id}"
    address = [yandex_compute_instance.app[count.index].network_interface.0.nat_ip_address]
  }
*/
  depends_on = [
    yandex_compute_instance.app
  ]
}

resource "yandex_lb_network_load_balancer" "app-lb" {

  name = "app-lb-01"
  deletion_protection = false
  listener {
    name = "app-lb-01-9292"
    port = 9292
    external_address_spec {
      ip_version = "ipv4"
    }
  }
  attached_target_group {
    target_group_id = "${yandex_lb_target_group.app-lb-tg.id}"
    healthcheck {
      name = "http"
      http_options {
        port = 9292
        path = "/"
      }
    }
  }
}
