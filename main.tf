provider "docker" {}

# Docker image resource
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

# Docker container resource
resource "docker_container" "nginx" {
  image = docker_image.nginx.name
  name  = "nginx-server"
  ports {
    internal = 80
    external = var.port
  }
  volumes {
    container_path = "/usr/share/nginx/html"
    host_path      = abspath("${path.module}/html")
  }
}

# Create a directory for custom html
resource "local_file" "index_html" {
  content  = "<html><body><h1>${var.message}</h1></body></html>"
  filename = "${path.module}/html/index.html"
}

output "url" {
  value = "http://localhost:${var.port}"
}
