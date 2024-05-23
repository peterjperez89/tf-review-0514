output "sgid" {
  value = aws_security_group.albsg.id
}

output "tg1id" {
  value = aws_alb_target_group.tg1.id
}