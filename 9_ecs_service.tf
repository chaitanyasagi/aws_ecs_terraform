resource "aws_ecs_service" "nginx_ecs_service" {
  name                               = var.ecs_service["name"]
  iam_role                           = aws_iam_role.ecs_service_role.name
  cluster                            = aws_ecs_cluster.ecs_cluster.id
  task_definition                    = aws_ecs_task_definition.nginx_app.family
  desired_count                      = var.auto_scaling["desired_capacity"]
  deployment_maximum_percent         = var.ecs_service["max_health_percent"]
  deployment_minimum_healthy_percent = var.ecs_service["min_health_percent"]

  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.arn
    container_port   = var.ecs_service["load_balancer_port"]
    container_name   = var.task_definition["name"]
  }
}
