resource "null_resource" "foooobar" {
  provisioner "local-exec" {
    command = "echo foobar"
  }
}
