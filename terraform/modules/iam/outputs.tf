output "ecs_execution_role_arn" {
  value = data.aws_iam_role.lab_role.arn
}

output "ecs_task_role_arn" {
  value = data.aws_iam_role.lab_role.arn
}

output "ecs_instance_profile_name" {
  value = data.aws_iam_instance_profile.lab.name
}

output "ecs_instance_role_name" {
  value = data.aws_iam_role.lab_role.name
}
