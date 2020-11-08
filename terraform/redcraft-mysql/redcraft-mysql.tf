resource "scaleway_instance_ip" "public_ip" {
  lifecycle {
    prevent_destroy = true
  }
}

resource "scaleway_instance_security_group" "mysql_security_group" {
  name = "redcraft-mysql-${var.env_name}"

  inbound_default_policy = "drop"
  outbound_default_policy = "accept"

  inbound_rule {
    action = "accept"
    port = "22"
    ip_range = "10.0.0.0/8"
  }

  inbound_rule {
    action = "accept"
    port = "3306"
    ip_range = "10.0.0.0/8"
  }
}

data "scaleway_image" "mysql_image" {
  architecture = "x86_64"

  name_filter = "redcraft-mysql-*"
}

resource "scaleway_instance_volume" "mysql_data" {
  size_in_gb = var.attached_disk_size
  type = "b_ssd"
  name = "redcraft-mysql-${var.env_name}-data"

  lifecycle {
    prevent_destroy = true
  }
}

resource "scaleway_instance_server" "mysql_instance" {
  type  = var.instance_type
  image = data.scaleway_image.mysql_image.id

  name = "redcraft-mysql-${var.env_name}"

  ip_id = scaleway_instance_ip.public_ip.id

  security_group_id = scaleway_instance_security_group.mysql_security_group.id

  additional_volume_ids = [ scaleway_instance_volume.mysql_data.id ]
}
