//asg config
resource "aws_autoscaling_group" "asg1" {
  name             = "ASG1"
  max_size         = 5
  min_size         = 1
  desired_capacity = 2
  launch_template {
    id      = var.lt1id
    version = var.lt1ver
  }
  health_check_type   = "ELB"
  vpc_zone_identifier = [var.snid1, var.snid2]
  target_group_arns   = [var.tg1id]
}