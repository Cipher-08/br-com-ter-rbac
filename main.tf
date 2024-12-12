resource "null_resource" "foobar" {
  provisioner "local-exec" {
    command = "echo foobar"
  }
}
