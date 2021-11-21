output "role_name" {
  value = module.ec2_iam_role.iam_role.name
}

output "profile_name" {
  value = aws_iam_instance_profile.profile.name
}

