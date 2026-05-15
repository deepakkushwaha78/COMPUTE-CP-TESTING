locals {
  # This ensures every networking resource has the exact same 7 tags
  standard_tags = {
    "Organization"   = var.org_name
    "ManagedBy"      = "terraform"
    "Project"        = var.project_name
    "Service"        = "networking"
    "Environment"    = var.environment
    "Component"      = "vpc"
    "ResourceType"   = "network-base"
    "TerraformState" = "${var.org_name}-terraform-states/${var.project_name}/network.tfstate"
  }

  # Dynamic naming convention
  resource_prefix = "${var.org_name}-${var.project_name}-${var.environment}"
}