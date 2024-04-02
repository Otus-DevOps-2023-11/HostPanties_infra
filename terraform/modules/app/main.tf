resource "yandex_compute_instance" "reddit-app" {
  name = var.name
  labels = {
    tags = "reddit-app"
  }
  resources {
    cores = 2
    memory = 2
  }
  boot_disk {
    initialize_params {
      image_id = var.app_disk_image
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
    host = yandex_compute_instance.reddit-app.network_interface.0.nat_ip_address
    type = "ssh"
    user = "ubuntu"
    private_key = file("/home/administrator/.ssh/id_rsa")
  }
  provisioner "file" {
    source = var.puma-service-file
    destination = "/tmp/puma.service"
  }
  provisioner "file" {
    source = var.deploy-file
    destination = "/tmp/deploy.sh"
  }
  provisioner "remote-exec" {
    inline = ["chmod +x /tmp/deploy.sh",
      "/tmp/deploy.sh ${var.db_ext_ip}"]
  }
  provisioner "remote-exec" {
    inline = [
    "sudo sed -i 's/ext_db_ip/${var.db_ext_ip}/g' /etc/systemd/system/puma.service",
    "sudo systemctl daemon-reload",
    "sudo systemctl restart puma "]
  }
}
