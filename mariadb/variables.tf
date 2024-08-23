variable "supporting_resources_name" {
  type        = string
  description = "The stack name for supporting resources launched separately"
  default     = "default"
}

variable "identifier" {
  description = "(Optional) The name of the RDS instance, if omitted, Terraform will assign a random, unique identifier. Required if restore_to_point_in_time is specified."
  type        = string
  default     = "casadeoraciondb"
}

variable "tags" {
  type        = map(string)
  description = "The resource tags to be applied"
  default = {
    Environment        = "development"
    "user::CostCenter" = "terraform-registry"
    Department         = "DevOps"
    Project            = "Casa de Oracion"
    InstanceScheduler  = true
    Owner              = "melvin.miculax"
    LayerName          = "casadeoracion-db"
    LayerId            = "casadeoracion-db"
  }
}

variable "engine" {
  type        = string
  description = "The database engine to use."
  default     = "mariadb"
}

variable "instance_class" {
  type        = string
  description = "The instance class for your instance(s)."
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  type        = number
  description = "Enter allocated storage for the db"
  default     = 20
}

variable "max_allocated_storage" {
  type        = number
  description = "The upper limit to which Amazon RDS can automatically scale the storage of the DB instance."
  default     = 30
}

variable "multi_az" {
  type        = bool
  description = "Boolean if specified leave availability_zone empty, default = false"
  default     = false
}

variable "enabled_cloudwatch_logs_exports" {
  type        = list(string)
  description = "List of log types to enable for exporting to CloudWatch logs."
  default     = ["error", "audit", "general", "slowquery"]
}

variable "create_monitoring_role" {
  type        = bool
  description = "Create an IAM role for enhanced monitoring"
  default     = true
}

variable "monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance."
  type        = number
  default     = 30
}

variable "create_option_group" {
  type        = bool
  description = "whether to create option_group resource or not"
  default     = true
}

variable "deletion_protection" {
  type        = bool
  description = "If the DB instance should have deletion protection enabled. The database can't be deleted when this value is set to true. The default is false."
  default     = false
}

variable "major_engine_version" {
  type        = string
  description = "Specify the major version of the engine that this option group should be associated with."
  default     = "10.11"
}

variable "engine_version" {
  type        = string
  description = "Specify the version of the engine for this db"
  default     = "10.11.8"
}