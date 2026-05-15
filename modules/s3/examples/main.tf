module "aws_s3_bucket" {
  source                               = "../"
  name                                 = var.name
  iam_policy                           = var.iam_policy
  attach_iam_policy                    = var.attach_iam_policy
}