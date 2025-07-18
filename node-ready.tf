locals {
  node_ready_filter = coalesce(
    var.node_ready_filter_override,
    var.filter_str
  )
}

module "node_ready" {
  # source  = "kabisa/generic-monitor/datadog"
  # version = "1.0.0"
  source = "github.com/Zilch-Technology/terraform-datadog-generic-monitor"

  name             = "Node Not Ready"
  query            = "avg(${var.node_ready_evaluation_period}):default_zero(max:kubernetes_state.node.by_condition{${local.node_ready_filter} AND (NOT condition:ready) AND (status:true OR status:unknown)} by {kube_cluster_name,host,kube_node}) > ${var.node_ready_critical}"
  alert_message    = "Kubernetes cluster node {{host}} is not ready."
  recovery_message = "Kubernetes cluster node {{host}} is ready again."

  # monitor level vars
  enabled            = var.state_metrics_monitoring && var.node_ready_enabled
  alerting_enabled   = var.node_ready_alerting_enabled
  critical_threshold = var.node_ready_critical
  # no warning threshold for this monitor
  priority = min(var.node_ready_priority + var.priority_offset, 5)
  docs     = var.node_ready_docs
  note     = var.node_ready_note

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
