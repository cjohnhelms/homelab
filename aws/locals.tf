locals {
  config = yamldecode(file("./terraform.yaml"))
}