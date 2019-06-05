variable "application" {
  default = "playground"
}

variable "provisionersrc" {
  default = "orbs-network/terraform-playground-node"
}

variable "vpc_cidr_block" {
  description = "The VPC CIDR address range"
  default     = "172.31.0.0/16"
}

variable "instance_type" {
  default = "m4.large"
}

variable "ssh_keypath" {
  default = "~/.ssh/id_rsa.pub"
}

variable "ssh_private_keypath" {
  default = "~/.ssh/id_rsa"
}

variable "region" {
  default = "ca-central-1"
}

variable "aws_profile" {
  default = "default"
}

