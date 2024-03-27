variable "port" {
  description = "Port for the nginx container"
  default     = 8081
  type        = number
}

variable "message" {
  description = "Message to display on the webpage"
  type        = string
}