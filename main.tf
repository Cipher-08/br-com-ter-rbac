resource "null_resource" "fooobar" {
  provisioner "local-exec" {
    command = "echo foobar"
  }
}
