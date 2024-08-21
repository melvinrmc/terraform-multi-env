variable "environment" {
  description = "Environment"
  type = string
  default = "dev"
}

variable "additional_tags" {
  default     = {}
  description = "Additional resource tags"
  type        = map(string)
}

variable "queue_name_tag" {
 type        = string
 description = "Name of the members queue"
 default     = "members-queue"
}

variable "queue_lambda_triggered_arn" {
 type        = string
 description = "arn of lambda to be triggered"
}