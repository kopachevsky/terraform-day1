variable "message" {
  type    = string
  description = "Message for index.html"
  default = "already working"
  }

variable "port" {
  type    = number
  description = "port for published_port"
  default = 8080
}

variable "port_tar" {
  type    = number
  description = "port for target_port"
  default = 80
}