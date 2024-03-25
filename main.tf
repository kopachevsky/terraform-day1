terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.13.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:alpine"
  keep_locally = true
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.name
  name  = "nginx_example"
  ports {
    internal = 80
    external = var.port
  }
  volumes {
    container_path = "/usr/share/nginx/html"
    host_path      = abspath("${path.module}/content")
    read_only      = true
  }
}

resource "local_file" "index_html" {
  content  = templatefile("${path.module}/templates/index.tpl", { message = var.message })
  filename = "${path.module}/content/index.html"
}

# Видаліть або закоментуйте дублюючий ресурс "docker_container" "nginx", щоб уникнути помилки.
