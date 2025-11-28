resource "aws_ecs_cluster" "nodeCluster" {
    name = "${var.project_name}-nodeCluster"

    setting {
        name = "containerInsights"
        value = "enabled"
    }
}
resource "aws_cloudwatch_log_group" "nodeloggroup" {
    retention_in_days = 30
    name = "/ecs/${var.project_name}-log-group"
}
resource "aws_ecs_task_definition" "nodetaskDef" {
    family = "${var.project_name}-nodetaskdef"
    requires_compatibilities = ["FARGATE"]
    network_mode = "awsvpc"
    cpu = 1024
    memory = 1024
    task_role_arn = aws_iam_role.task_role.arn
    execution_role_arn = aws_iam_role.execution_role.arn

    container_definitions = jsonencode ([
        {
            name = "node-app"
            image = "${aws_ecr_repository.noderepo.repository_url}:latest"
            cpu = 512
            memory = 512
            portMappings = [{
                containerPort = 3000
                protocol = "tcp"
            }]
            logConfiguration = {
                options = {
                awslogs-group = aws_cloudwatch_log_group.nodeloggroup.name
                awslogs-region = "ap-south-1"
                awslogs-stream-prefix = "app"
            }          
        }
        }
    ])
}
resource "aws_ecs_service" "nodeserv" {
    name = "${var.project_name}-service"
    cluster = aws_ecs_cluster.nodeCluster.name
    task_definition = aws_ecs_task_definition.nodetaskDef.arn
    launch_type = "FARGATE"
    desired_count = 5
}