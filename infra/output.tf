output "ecr_repo_url" {
    value = aws_ecr_repository.noderepo.repository_url
}

output "ecr_cluster_name"{
    value = aws_ecs_cluster.nodeCluster.name
}

output "ecs_service" {
    value = aws_ecs_service.nodeserv
}

output "s3_bucket_arn" {
    value = aws_s3_bucket.my_bucket.arn
}
