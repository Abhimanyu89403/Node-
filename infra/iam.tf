resource "aws_iam_role" "execution_role" {
    name = "${var.project_name}-execution-role"

    assume_role_policy = jsonencode({
        Version = "2012-10-17",
        Statement = [{
            Effect = "Allow",
            Principal = {
                Service = "ecs-tasks.amazonaws.com"
                },
            Action = "sts:AssumeRole"
        }]
    })
}
resource "aws_iam_role_policy_attachment" "execution_attachment" {
    role = aws_iam_role.execution_role.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "task_role" {
    name = "${var.project_name}-task_role"
    
    assume_role_policy = jsonencode ({
        Version = "2012-10-17"
        Statement = [{
            Effect = "Allow"
            Principal = {
                Service = "ecs-tasks.amazonaws.com"
            },
            Action = "sts:Assumerole"
        }]
    })
}
resource "aws_iam_policy" "s3_read_write_policy" {
    name = "${var.project_name}-s3-policy"

    policy = jsonencode ({
        Version = "2012-10-17"
        Statement = [{
            Effect = "Allow"
            Action = [
                "s3:PutObject",
                "s3:GetObject",
                "s3:ListObject"
            ],
            Resource = [
                "${aws_s3_bucket.my_bucket.arn}",
                "${aws_s3_bucket.my_bucket.arn}/*"

            ]
        }]
    })
}
resource "aws_iam_role_policy_attachment" "s3_attachment" {
    role = aws_iam_role.task_role.name
    policy_arn = aws_iam_policy.s3_read_write_policy.arn
}