resource "null_resource" "foooobar" {
  provisiner "local-exec" {{
    command = "echo foobar"
  }
}
