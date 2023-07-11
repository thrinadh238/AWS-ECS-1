data "aws_subnet" "ecs-subnet" {
  filter {
    name   = "tag:Name"
    values = ["ecs-1"]
  }
}
output "ecs_subnet_id" {
  value = data.aws_subnet.ecs-subnet.id
}

data "aws_security_group" "ecs-sg" {
  filter {
    name   = "tag:Name"
    values = ["ecs"]
  }
}
output "ecs_sg_id" {
  value = data.aws_security_group.ecs-sg.id
}
