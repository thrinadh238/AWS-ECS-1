############CREATING A ECS CLUSTER#############

resource "aws_ecs_cluster" "cluster" {
  name = "cluster"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "task" {
  family                   = "service"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE", "EC2"]
  cpu                      = 512
  memory                   = 2048
  container_definitions    = <<DEFINITION
  [
    {
      "name"      : "busybox",
      "image"     : "769839497771.dkr.ecr.us-east-1.amazonaws.com/busybox:1.31.1",
      "cpu"       : 512,
      "memory"    : 2048,
      "essential" : true,
      "portMappings" : [
        {
          "containerPort" : 80,
          "hostPort"      : 80
        }
      ]
    }
  ]
  DEFINITION
}

resource "aws_ecs_service" "service" {
  name             = "service"
  cluster          = aws_ecs_cluster.cluster.id
  task_definition  = aws_ecs_task_definition.task.id
  desired_count    = 1
  launch_type      = "EC2"
  platform_version = "LATEST"

  network_configuration {
    assign_public_ip = true
    security_groups  = [data.aws_security_groups.ecs-sg.id]
    subnets          = [data.aws_subnet.ecs-subnet.id]
  }
  lifecycle {
    ignore_changes = [task_definition]
  }
}
