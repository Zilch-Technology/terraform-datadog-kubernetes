locals {
  jobs_failed_filter = coalesce(
    var.jobs_failed_filter_override,
    var.filter_str
  )
}

module "jobs_failed" {
  # source  = "kabisa/generic-monitor/datadog"
  # version = "1.0.0"
  source = "/Users/philip.stevenson/code/github/Zilch-Technology/terraform-datadog-generic-monitor"

  name  = "jobs failed"
  query = "min(${var.jobs_failed_evaluation_period}):sum:kubernetes_state.job.failed{${local.jobs_failed_filter}} by {kube_cronjob,kube_cluster_name,kube_namespace,kube_job} > ${var.jobs_failed_critical}"

  # alert specific configuration
  require_full_window = true
  alert_message       = "Kubernetes jobs failed ({{ value }}) in {{ service }} exceeds {{ threshold }}"
  recovery_message    = "Kubernetes jobs failed ({{ value }}) in {{ service }} has recovered"

  # monitor level vars
  enabled             = var.jobs_failed_enabled
  alerting_enabled    = var.jobs_failed_alerting_enabled
  warning_threshold   = var.jobs_failed_warning
  critical_threshold  = var.jobs_failed_critical
  priority            = min(var.jobs_failed_priority + var.priority_offset, 5)
  docs                = var.jobs_failed_docs
  note                = var.jobs_failed_note
  auto_resolve_time_h = var.jobs_failed_auto_resolve_time_h

  # module level vars
  env                  = var.env
  service              = var.service
  service_display_name = var.service_display_name
  notification_channel = var.notification_channel
  additional_tags      = var.additional_tags
  locked               = null
  name_prefix          = var.name_prefix
  name_suffix          = var.name_suffix
}
