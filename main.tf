resource "null_resource" "foooooobar" {
  provisioner "local-exec" {
    command = "echo foobar"
  }
}
