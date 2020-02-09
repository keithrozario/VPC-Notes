terraform {
  backend "remote" {
    organization = "keith-security"

   workspaces {
      name = "VPC-security"
    }
  }
}