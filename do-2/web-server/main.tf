variable "ip_address" {}
variable "server_number" {}

resource "null_resource" "npm-echo-servers" {

  connection {
    host        = var.ip_address
    user        = "root"
    type        = "ssh"
    private_key = file("/Users/berkayozcan/.ssh/id_rsa")
    timeout     = "2m"
  }

  provisioner "file" {
    source      = "${path.module}/src/"
    destination = "~/"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x ~/setup.sh && ~/setup.sh ${var.server_number}",
    ]
  }
}
