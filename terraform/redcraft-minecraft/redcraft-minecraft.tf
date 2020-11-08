resource "scaleway_instance_ip" "public_ip" {}

resource "scaleway_instance_security_group" "minecraft_security_group" {
  name = "redcraft-minecraft-${var.env_name}"

  inbound_default_policy = "drop"
  outbound_default_policy = "accept"

  inbound_rule {
    action = "accept"
    port = "22"
    ip_range = "10.0.0.0/8"
  }

  inbound_rule {
    action = "accept"
    port = "25565"
  }

  inbound_rule {
    action = "accept"
    port = "25580"
  }
}

data "scaleway_image" "minecraft_image" {
  architecture = "x86_64"

  name_filter = "redcraft-minecraft-*"
}

resource "scaleway_instance_volume" "minecraft_data" {
  size_in_gb = var.attached_disk_size
  type = "b_ssd"
  name = "redcraft-minecraft-${var.env_name}-data"
}

resource "scaleway_instance_server" "minecraft_instance" {
  type  = var.instance_type
  image = data.scaleway_image.minecraft_image.id

  name = "redcraft-minecraft-${var.env_name}"

  ip_id = scaleway_instance_ip.public_ip.id

  security_group_id = scaleway_instance_security_group.minecraft_security_group.id

  additional_volume_ids = [ scaleway_instance_volume.minecraft_data.id ]
}
