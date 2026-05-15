terraform {
  backend "s3" {
    bucket = "nitin-observability-data-2026-1"
    key    = "observability/network.tfstate"
    region = "us-east-1"
  }
}
