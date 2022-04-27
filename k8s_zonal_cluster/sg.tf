# Create random string for the name of the SG
resource "random_string" "random" {
   length           = 16
   special          = true
}

resource "yandex_vpc_security_group" "security_group_2" {
  name = random_string.random.result
  network_id  = var.default_network_id

  dynamic "ingress" {
      for_each = ["80", "443", "6443"]
    content {
        from_port = ingress.value
        to_port = ingress.value
        protocol = "tcp"
        v4_cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "ANY"
      v4_cidr_blocks = ["0.0.0.0/0"]
  }
}