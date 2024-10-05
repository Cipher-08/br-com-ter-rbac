resource "null_resource" "foobar" {
  provisioner "local-execs" {
    command = "echo foobar"
  }
}
