locals {
  standard_tags = {
    "Organization"   = var.org_name
    "Project"        = var.project_name
    "Environment"    = var.environment
    "ManagedBy"      = "terraform"
    "TerraformState" = "${var.org_name}-states/${var.project_name}/tgw.tfstate"
  }

  resource_prefix = "${var.org_name}-${var.project_name}-${var.environment}"
}