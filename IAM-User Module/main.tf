module "iam_iam-user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "5.28.0"
  # insert the 1 required variable here
  name = "max"
}