variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
  default     = "europe-west3"
}

variable zone {
  description = "Zone"
  default     = "europe-west3-b"
}

variable public_key_path {
  description = "Path to public key used for SSH access"
}

variable private_key_path {
  description = "Path to private key used for SSH access"
}

variable disk_image {
  description = "Disk image"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-base-app"
}

variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-base-db"
}
