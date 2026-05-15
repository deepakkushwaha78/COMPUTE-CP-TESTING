# Observability Infrastructure Management

This repository contains Terraform code to manage the FCI Centralized Observability Infrastructure on AWS.

## Structure

- **accounts/centralised_observability/network**: VPC, subnets, NAT, jumphost, S3 for flow logs, Route 53 private zone.
- **accounts/centralised_observability/transit_gateway**: Centralized AWS Transit Gateway and VPC attachments.
- **accounts/centralised_observability/eks**: EKS cluster, node groups, IAM roles, and monitoring integrations.

Each component has its own README with detailed variables, outputs, and usage instructions.

## Prerequisites
- Terraform v1.12+
- AWS credentials configured
- S3 bucket for Terraform state (e.g., `fci-observability-terraform-states` in `ap-south-1`)

## Deployment Workflow

1. **Network**: Deploy VPC, subnets, NAT, jumphost, S3, and Route 53.
2. **Transit Gateway**: Deploy TGW and configure VPC attachments.
3. **EKS**: Deploy EKS cluster, node groups, and monitoring.

**Order matters:** Deploy in the above sequence for dependencies to resolve correctly.

## Quick Start

For each component:
1. Edit `terraform.tfvars` as needed.
2. Run:
   ```bash
   terraform init
   terraform plan -var-file=terraform.tfvars -out=plan.out
   terraform apply plan.out
   ```

Refer to each component's README for specific variables and outputs.

## Environments

- **Stage**: Region `ap-south-1`, VPC CIDR `10.250.0.0/16`, public/private subnets, and two AZs.

## Contributing
- Follow naming conventions
- Update documentation for changes
- Test in stage before production
- Use `terraform fmt`
- Document variables clearly

---

For detailed configuration, see the README in each subdirectory:
- [Network](accounts/centralised_observability/network/README.md)
- [Transit Gateway](accounts/centralised_observability/transit_gateway/README.md)
- [EKS](accounts/centralised_observability/eks/README.md)
