resource "aws_cloudformation_stack" "manage_backend_services" {
  name          = "ManageBackendServices"
  capabilities  = ["CAPABILITY_NAMED_IAM"]
  template_body = file("${path.module}/CloudFormationResource.yml")
}
