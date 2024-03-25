terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

resource "docker_config" "service_config" {
  name = "service"
  data = base64encode(
    templatefile("${path.cwd}/index.html.tpl",
      {
        message = var.message
      }
    )
  )
}

resource "docker_image" "nginx" {
  name         = "nginx"
  keep_locally = false
}

resource "docker_service" "service" {
  name = "fe_service"

  task_spec {
    container_spec {
      image = docker_image.nginx.image_id

      configs {
        config_id   = docker_config.service_config.id
        config_name = docker_config.service_config.name
        file_name   = "/usr/share/nginx/html/index.html"
      }
    }
  }

  endpoint_spec {
  
    ports {
      target_port    = var.port_tar
      published_port = var.port
      publish_mode   = "host"
    }
  }
}

#resource "docker_container" "nginx" {
#  image = docker_image.nginx.image_id
#  name  = "tutorial"

#  ports {
#   internal = var.port_tar
#   external = var.port
# }
#}
