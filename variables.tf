variable "message" {
  type        = string
  description = "The message to display in the nginx server"
}

variable "port" {
  type        = number
  description = "The host port to bind on the container"
  default     = 8080
}

output "link" {
  value = "http://localhost:${var.port}"
}