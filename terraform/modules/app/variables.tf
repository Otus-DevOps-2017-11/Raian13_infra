variable zone {
  description = "Zone"
  default     = "europe-west3-b"
}

variable public_key_path {
  description = "Path to public key used for SSH access"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-base-app"
}
