resource "null_resource" "foo8745bar" {
  provisioner "local-exec" {
    command = "echo foo0bar"
  }
}
