resource "aws_kms_key" "this" {
  count = var.create_kms_key ? 1 : 0

  description                        = "A map of additional tags to add to the kms key"
  key_usage                          = "ENCRYPT_DECRYPT"
  customer_master_key_spec           = "SYMMETRIC_DEFAULT"
  bypass_policy_lockout_safety_check = false
  deletion_window_in_days            = 10
  is_enabled                         = true
  enable_key_rotation                = false
  tags = merge(
    var.tags,
    var.kms_tags,
  )
}
