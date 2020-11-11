resource "scaleway_instance_ip" "public_ip" {
  lifecycle {
    prevent_destroy = true
  }
}

resource "scaleway_instance_security_group" "redis_security_group" {
  name = "redcraft-redis-${var.env_name}"

  inbound_default_policy = "drop"
  outbound_default_policy = "accept"

  inbound_rule {
    action = "accept"
    port = "22"
    ip_range = "10.0.0.0/8"
  }

  inbound_rule {
    action = "accept"
    port = "6379"
    ip_range = "10.0.0.0/8"
  }
}

data "scaleway_image" "redis_image" {
  architecture = "x86_64"

  name_filter = "redcraft-redis-*"
}

resource "scaleway_instance_server" "redis_instance" {
  type  = var.instance_type
  image = data.scaleway_image.redis_image.id

  name = "redcraft-redis-${var.env_name}"

  ip_id = scaleway_instance_ip.public_ip.id

  security_group_id = scaleway_instance_security_group.redis_security_group.id
}
