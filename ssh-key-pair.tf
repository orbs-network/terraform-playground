resource "aws_key_pair" "deployer" {
  key_name   = "${var.application}-${var.region}-keypair"
  public_key = "${file(var.ssh_keypath)}"
}
