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

variable instance_tag {
  description = "Instance identifier"
}

variable source_ranges {
  description = "Allowed IP addresses"
  default     = ["0.0.0.0/0"]
}
