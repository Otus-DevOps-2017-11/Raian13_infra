resource "google_compute_firewall" "firewall_ssh" {
  name = "default-allow-ssh"

  # В какой сети действует правило
  network = "default"

  # Какой доступ разрешить
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  # Каким адресам разрешаем доступ
  source_ranges = ["0.0.0.0/0"]

  # Описание правила
  description = "Allow SSH from anywhere"

}
