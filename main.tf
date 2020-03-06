provider "aws" {
    region = "us-east-1"
}

module "dev" {
  source = "env/dev"
}
