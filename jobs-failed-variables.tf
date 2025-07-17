variable "jobs_failed_enabled" {
  type    = bool
  default = true
}

variable "jobs_failed_warning" {
  type    = number
  default = null
}

variable "jobs_failed_critical" {
  type    = number
  default = 0.0
}

variable "jobs_failed_evaluation_period" {
  type    = string
  default = "last_10m"
}

variable "jobs_failed_note" {
  type    = string
  default = ""
}

variable "jobs_failed_docs" {
  type    = string
  default = "https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/"
}

variable "jobs_failed_filter_override" {
  type    = string
  default = ""
}

variable "jobs_failed_alerting_enabled" {
  type    = bool
  default = true
}

variable "jobs_failed_no_data_timeframe" {
  type    = number
  default = null
}

variable "jobs_failed_notify_no_data" {
  type    = bool
  default = false
}

variable "jobs_failed_ok_threshold" {
  type    = number
  default = null
}

variable "jobs_failed_name_prefix" {
  type    = string
  default = ""
}

variable "jobs_failed_name_suffix" {
  type    = string
  default = ""
}

variable "jobs_failed_priority" {
  description = "Number from 1 (high) to 5 (low)."

  type    = number
  default = 3
}

variable "jobs_failed_auto_resolve_time_h" {
  description = "Time in hours after which the monitor will automatically resolve if the alert condition is no longer met."
  type        = number
  default     = 1
}
