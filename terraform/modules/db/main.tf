resource "yandex_compute_instance" "db" {
  name = var.name
  labels = {
    tags = "reddit-db"
  }
  resources {
    cores = 2
    memory = 2
  }
  boot_disk {
    initialize_params {
      image_id = var.db_disk_image
    }
  }
  network_interface {
    subnet_id = var.subnet_id
    nat = true
  }
  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
  connection {
    host = yandex_compute_instance.db.network_interface.0.nat_ip_address
    private_key = file("/home/administrator/.ssh/id_rsa")
    user = "ubuntu"
    type = "ssh" 
  }
  provisioner "remote-exec" {
    inline = ["sudo sed -i 's/bind_ip = 127.0.0.1/bind_ip = 0.0.0.0/g' /etc/mongodb.conf",
    "sudo systemctl restart mongodb"]
  }
}
