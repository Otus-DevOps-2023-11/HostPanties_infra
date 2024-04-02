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
    host = self.network_interface.0.nat_ip_address
    type = "ssh" 
    user = "ubuntu"
    private_key = file(var.pub-key)
  }
  provisioner "remote-exec" {
    inline = ["sleep 180",
      "sudo sed -i 's/bind_ip = 127.0.0.1/bind_ip = 0.0.0.0/g' /etc/mongodb.conf",
    "sudo systemctl restart mongodb"]
  }
}
