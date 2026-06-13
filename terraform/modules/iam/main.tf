# Learner Lab provides pre-existing LabRole — cannot create custom IAM roles
data "aws_iam_role" "lab_role" {
  name = var.lab_role_name
}

data "aws_iam_instance_profile" "lab" {
  name = var.lab_instance_profile_name
}
