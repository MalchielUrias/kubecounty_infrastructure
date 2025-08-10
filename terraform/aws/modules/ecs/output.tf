output "cluster_name" {
  value = aws_ecs_cluster.this.name
}

output "arn" {
  value = aws_ecs_cluster.this.arn
}