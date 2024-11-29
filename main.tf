resource "null_resource" "fooba65r" {
  provisioner "local-execs" {
    command = "echo foobar"
  }
}
