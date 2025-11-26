resource "aws_iam_role" "task_role" {
    name = "${var.project_name}-execution-role"

    assume_role_policy = jsonencode({
        Version = "2012-10-17",
        Statement = [{
            Effect = "Allow",
            Principal = {Service = "ecs.amazonaws.com"},
            Action = "sts:AssumeRole"
        }]
    })
}

resource "aws_iam_role_policy_attachment" "execution_attachment" {
    role = aws_iam_role.task_role.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}