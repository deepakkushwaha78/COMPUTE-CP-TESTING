
/*-------------------------------------------------------*/
variable "applicaton_name" {
  type = string
}
variable "applicaton_port" {
  type = number
}
variable "applicaton_health_check_target" {
  type = string
}
/*-------------------------------------------------------*/
variable "tg_target_type" {
  type    = string
  default = "instance"
}
variable "tg_protocol" {
  type    = string
  default = "HTTP"
}
variable "vpc_id" {
  type = string
}
/*-------------------------------------------------------*/
variable "instance_id" {
  type = string
}

# Variable to control whether to add a listener rule

variable "listener_arn" {
  description = "LB Listerner arn"
  type        = string
}


variable "add_listener_rule" {
  description = "Flag to determine whether to add a listener rule for the target group"
  type        = bool
  default     = false
}

variable "listener_rule_priority" {
  description = "The priority of the listener rule"
  type        = number
  default     = 100
}

variable "listener_rule_host_headers" {
  description = "The host headers for the listener rule"
  type        = list(string)
  default     = [""]
}