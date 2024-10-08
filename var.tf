variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "role" {
  description = "IAM role for the crawler"
  type        = string
  default     = "null"
}

variable "s3_bucket1" {
  description = "Name of the bucket1"
  type        = string
  default     = "ddsl-raw-develop"
}

variable "s3_bucket2" {
  description = "Name of the bucket2"
  type        = string
  default     = "ddsl-raw-extended-develop"
}

variable "s3_bucket3" {
  description = "Name of the bucket3"
  type        = string
  default     = "ddsl-dq-develop"
}

variable "s3_bucket4" {
  description = "Name of the bucket4"
  type        = string
  default     = "ddsl-processed-develop"
}

variable "s3_bucket5" {
  description = "Name of the bucket5"
  type        = string
  default     = "ddsl-odsl-domain-develop"
}
