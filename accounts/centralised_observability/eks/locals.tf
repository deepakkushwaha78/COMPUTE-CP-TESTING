locals {
  # This creates the standard "base" tags for every resource in this project
  standard_tags = {
    "Organization"   = var.org_name
    "ManagedBy"      = "terraform"
    "Project"        = var.project_name
    "Service"        = var.project_name
    "Component"      = "eks" # This can be overridden per-resource if needed
    "ResourceType"   = "generic" # Placeholder to be overridden
    "TerraformState" = "${var.org_name}-terraform-states/${var.project_name}/eks.tfstate"
  }
}