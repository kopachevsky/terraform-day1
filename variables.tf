variable "message" {
  description = "Текстове повідомлення для відображення"
  type        = string
  default     = "Hello, World!"
}

variable "port" {
  description = "Порт на локальній машині"
  type        = number
  default     = 8080
}