terraform {
  backend "s3" {
    bucket = "nitin-observability-data-2026-1"
    key    = "observability/tgw.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "nitin-observability-data-2026-1"
    key    = "observability/network.tfstate"
    region = "us-east-1"
  }
}
