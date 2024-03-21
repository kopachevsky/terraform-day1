variable "message" {
  type = string
}

variable "port" {
  type = number
}

output "link" {
  value = "http://localhost:${var.port}"
}