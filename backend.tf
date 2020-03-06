terraform {
  backend "s3" {
    bucket = "halturi-terrafrom-state-backend"
    key    = "terraform"
    region = "us-east-1"
  }
}