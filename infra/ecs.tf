resource "aws_ecs_cluster" "nodeCluster" {
    name = "${var.project_name}-nodeCluster"
}

resource "aws_ecs_task_definition" "nodetaskDef" {
    family = "${var.project_name}-nodetaskdef"
    requires_compatibilities = "FARGATE"
    network_mode = "awsvpc"
    cpu = 1024
    memory = 1024
    execution_role_arn = aws_iam_role.task_role.arn

    container_definitions = jsonencode ([
        {
            name = "noded-=app"
            image = "${aws_ecr_repository.noderepo.repository_url}:latest"
            cpu = 512
            memory = 512
            portMappings = [{
                containerPort = 3000
                protocol = "tcp"
            }]            
        }
    ])
}

resource "aws_ecs_service" "nodeserv" {
    name = "${var.project_name}-service"
    cluster = aws_ecs_cluster.nodeCluster.name
    task_definition = aws_ecs_task_definition.nodetaskDef.name
}