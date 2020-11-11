resource "scaleway_instance_ip" "public_ip" {
  lifecycle {
    prevent_destroy = true
  }
}

resource "scaleway_instance_security_group" "vpn_security_group" {
  name = "redcraft-vpn-${var.env_name}"

  inbound_default_policy = "drop"
  outbound_default_policy = "accept"

  inbound_rule {
    action = "accept"
    port = "22"
    ip_range = "10.0.0.0/8"
  }

  inbound_rule {
    action = "accept"
    port = "80"
  }

  inbound_rule {
    action = "accept"
    port = "443"
  }

  inbound_rule {
    action = "accept"
    protocol = "UDP"
    port = "10839"
  }

  inbound_rule {
    action = "accept"
    protocol = "UDP"
    port = "17250"
  }
}

data "scaleway_image" "vpn_image" {
  architecture = "x86_64"

  name_filter = "redcraft-vpn-*"
}

resource "scaleway_instance_server" "vpn_instance" {
  type  = var.instance_type
  image = data.scaleway_image.vpn_image.id

  name = "redcraft-vpn-${var.env_name}"

  ip_id = scaleway_instance_ip.public_ip.id

  security_group_id = scaleway_instance_security_group.vpn_security_group.id
}
