
resource "aws_instance" "simple_db_instance" {
  ami             = "ami-06c68f701d8090592"
  instance_type   = "t2.micro"
  key_name        = "aws-joe-key"

  tags = merge(
    var.additional_tags,
    {
      Name = format("%s_%s", "simple_db_instance", terraform.workspace)
    },
  )
}

resource "aws_ec2_instance_state" "status_simple_db_instance" {
  instance_id = aws_instance.simple_db_instance.id
  state       = "stopped"
}

resource "aws_sqs_queue" "members_queue" {
  name = format("%s_%s", "members_queue", terraform.workspace)

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.members_queue_deadletter.arn
    maxReceiveCount     = 4
  })

    tags = merge(
    var.additional_tags,
    {
      Name = format("%s_%s", var.queue_name_tag, terraform.workspace)
    },
  )

}

resource "aws_sqs_queue" "members_queue_deadletter" {

  name = format("%s_%s", "members_queue_deadletter", terraform.workspace)

    tags = merge(
    var.additional_tags,
    {
      Name = format("%s_%s", var.queue_name_tag, terraform.workspace)
    },
  )

}

resource "aws_sqs_queue_redrive_allow_policy" "terraform_queue_redrive_allow_policy" {
  queue_url = aws_sqs_queue.members_queue_deadletter.id

  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue",
    sourceQueueArns   = [aws_sqs_queue.members_queue.arn]
  })
}

resource "aws_lambda_event_source_mapping" "event_source_mapping" {
  batch_size        = 1
  event_source_arn  = "${aws_sqs_queue.members_queue.arn}"
  enabled           = true
  function_name     = "${var.queue_lambda_triggered_arn}"
}