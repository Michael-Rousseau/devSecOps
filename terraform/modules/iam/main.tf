# Learner Lab provides pre-existing LabRole — cannot create custom IAM roles
data "aws_iam_role" "lab_role" {
  name = "LabRole"
}

data "aws_iam_instance_profile" "lab" {
  name = "LabInstanceProfile"
}
