resource "google_compute_instance" "db" {
  name         = "${var.instance_tag}"
  machine_type = "g1-small"
  zone         = "${var.zone}"

  # определение загрузочного диска
  boot_disk {
    initialize_params {
      image = "${var.db_disk_image}"
    }
  }

  # определение сетевого интерфейса
  network_interface {
    # сеть, к которой присоединить данный интерфейс
    network = "default"

    # использовать ephemeral IP для доступа из Интернет
    access_config {}
  }

  metadata {
    sshKeys = "appuser:${file(var.public_key_path)}"
  }

  tags = ["${var.instance_tag}"]
}

resource "google_compute_firewall" "firewall_mongo" {
  name = "allow-mongo-default"

  # В какой сети действует правило
  network = "default"

  # Какой доступ разрешить
  allow {
    protocol = "tcp"
    ports    = ["27017"]
  }

  # Правило применимо для инстансов с тэгом ...
  target_tags = ["${var.instance_tag}"]

  # Порт будет доступен только для инстансов с тэгом ...
  source_tags = ["reddit-app"]
}
