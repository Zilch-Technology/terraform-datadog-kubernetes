locals {
  cpu_limits_low_perc_filter = coalesce(
    var.cpu_limits_low_perc_filter_override,
    var.filter_str
  )
}

module "cpu_limits_low_perc" {
  # source  = "kabisa/generic-monitor/datadog"
  # version = "1.0.0"
  source = "github.com/Zilch-Technology/terraform-datadog-generic-monitor"

  name             = "Available CPU for Limits in percentages Low"
  query            = "max(${var.cpu_limits_low_perc_evaluation_period}):(sum:kubernetes.cpu.limits{${local.cpu_limits_low_perc_filter}} by {host,kube_cluster_name} / max:system.cpu.num_cores{${local.cpu_limits_low_perc_filter}} by {host,kube_cluster_name}) * 100 > ${var.cpu_limits_low_perc_critical}"
  alert_message    = "Kubernetes cluster {{kube_cluster_name.name}} cpu room for limits / percentage is too low"
  recovery_message = "Kubernetes cluster {{kube_cluster_name.name}} cpu limits / percentage has recovered"

  # monitor level vars
  enabled            = var.cpu_limits_low_perc_enabled
  alerting_enabled   = var.cpu_limits_low_perc_alerting_enabled
  critical_threshold = var.cpu_limits_low_perc_critical
  warning_threshold  = var.cpu_limits_low_perc_warning
  priority           = min(var.cpu_limits_low_perc_priority + var.priority_offset, 5)
  docs               = var.cpu_limits_low_perc_docs
  note               = var.cpu_limits_low_perc_note

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
