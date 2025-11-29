
# ECS CLUSTER 

resource "aws_ecs_cluster" "this" {
  name = var.cluster_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}


# IAM ROLE 

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.cluster_name}-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "ecs-tasks.amazonaws.com" },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "ecs_task_role" {
  name = "${var.cluster_name}-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "ecs-tasks.amazonaws.com" },
      Action = "sts:AssumeRole"
    }]
  })
}


# LOGS GROUP   

resource "aws_cloudwatch_log_group" "ecs_logs" {
  name              = "/ecs/${var.container_name}"
  retention_in_days = 7
}


# TASK DEFINITION  

resource "aws_ecs_task_definition" "this" {
  family                   = var.container_name
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn      = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = var.ecr_image
      essential = true

      portMappings = [{
        containerPort = var.container_port
        hostPort      = var.container_port
        protocol      = "tcp"
      }]

      

      environment = [
        { name = "SECRET_KEY",               value = var.outline_secret_key },
        { name = "UTILS_SECRET",             value = var.outline_utils_secret },
        { name = "DATABASE_URL",             value = var.database_url },
        { name = "REDIS_URL",                value = var.redis_url },
        { name = "FILE_STORAGE",             value = "s3" },
        { name = "AWS_REGION",               value = var.aws_region },
        { name = "AWS_S3_UPLOAD_BUCKET_URL", value = "https://${var.s3_bucket_name}.s3.${var.aws_region}.amazonaws.com" },
        { name = "AWS_S3_UPLOAD_BUCKET_NAME", value = var.s3_bucket_name },
        { name = "AWS_S3_FORCE_PATH_STYLE",   value = "true" },
        { name = "URL",                       value = var.public_url },
        { name = "FORCE_DEPLOY",              value = timestamp() }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.ecs_logs.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = var.container_name
        }
      }
    }
  ])
}


# ECS SERVICE  

resource "aws_ecs_service" "this" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.private_subnets
    security_groups  = [var.ecs_sg_id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  depends_on = [
    var.alb_listener_arn
  ]
}
