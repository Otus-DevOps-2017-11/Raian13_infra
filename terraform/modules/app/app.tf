resource "google_compute_instance" "app" {
  name         = "${var.instance_tag}"
  machine_type = "g1-small"
  zone         = "${var.zone}"

  # определение загрузочного диска
  boot_disk {
    initialize_params {
      image = "${var.app_disk_image}"
    }
  }

  # определение сетевого интерфейса
  network_interface {
    # сеть, к которой присоединить данный интерфейс
    network = "default"

    # использовать ephemeral IP для доступа из Интернет
    access_config {
      nat_ip = "${google_compute_address.app_ip.address}"
    }
  }

  metadata {
    sshKeys = "appuser:${file(var.public_key_path)}"
  }

  tags = ["${var.instance_tag}"]
}

resource "google_compute_address" "app_ip" {
  name = "${var.instance_tag}-ip"
}

resource "google_compute_firewall" "firewall_puma" {
  name = "allow-puma-default"

  # В какой сети действует правило
  network = "default"

  # Какой доступ разрешить
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }

  # Каким адресам разрешаем доступ
  source_ranges = "${var.source_ranges}"

  # Правило применимо для инстансов с тэгом ...
  target_tags = ["${var.instance_tag}"]
}

resource "google_compute_firewall" "firewall_nginx" {
  name = "allow-http-default"

  # В какой сети действует правило
  network = "default"

  # Какой доступ разрешить
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  # Каким адресам разрешаем доступ
  source_ranges = "${var.source_ranges}"

  # Правило применимо для инстансов с тэгом ...
  target_tags = ["${var.instance_tag}"]
}