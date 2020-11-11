resource "scaleway_instance_ip" "public_ip" {
  lifecycle {
    prevent_destroy = true
  }
}

resource "scaleway_instance_security_group" "django_security_group" {
  name = "redcraft-django-${var.env_name}"

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
}

data "scaleway_image" "django_image" {
  architecture = "x86_64"

  name_filter = "redcraft-django-*"
}

resource "scaleway_instance_server" "django_instance" {
  type  = var.instance_type
  image = data.scaleway_image.django_image.id

  name = "redcraft-django-${var.env_name}"

  ip_id = scaleway_instance_ip.public_ip.id

  security_group_id = scaleway_instance_security_group.django_security_group.id
}
