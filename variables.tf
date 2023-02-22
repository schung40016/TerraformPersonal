variable "project_name" {
  type = string # "PokeAPI"
}

variable "resource_location" {
  type = string # "westus2"
}

variable "sqladmin_username" {
  type = string # "doogieboogie"
}

variable "sqladmin_password" {
  type = string # "howdybro123"
}

variable "vnet_address" {
  type = string # ""10.0.0.0/16""
}

variable "func_count" {
  type = number # 2
}

variable "logic_count" {
  type = number #2
}
