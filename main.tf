resource "null_resource" "foobar" {
  provisiner "local-exec" {
    command = "echo foobar"
  }
}
