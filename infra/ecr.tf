resource "aws_ecr_repository" "noderepo" {
    name = "${var.project_name}-node-repo"
    image_scanning_configuration  {
        scan_on_push = true
    }
    encryption_configuration {
        encryption_type = "AES_256"
    }
}

resource "aws_ecr_lifecycyle_policy" "policy" {
    repository = aws_ecr_repository.noderepo.name

    policy = <<EOF
{
    "rules" :[
    {
        "rulePriority" : 1,
        "description" : "Keep only 15 images and delete the rest"
        "selection" : {
            "tagStatus : "any"
            "countType" : "imageCountMorethan"
            "countNumber" : "15" 
        },
        "action" : {
            "type" :"expire"
        }
    }
    ]
}
EOF  
}