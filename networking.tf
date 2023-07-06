data "aws_subnet" "ecs-subnet" {
  filter {
    name   = "tag:Name"
    values = ["ecs-subnet"]
  }
}
output "ecs_subnet_id" {
  value = data.aws_subnet.ecs-subnet.id
}

data "aws_security_groups" "ecs-sg" {
  filter {
    name   = "tag:Name"
    values = ["ecs-sg"]
  }
}
output "ecs_sg_id" {
  value = data.aws_security_groups.ecs-sg.id
}
