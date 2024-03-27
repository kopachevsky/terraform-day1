resource "docker_image" "nginx" {
  name         = "nginx"
  keep_locally = true
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.name
  name  = "nginx"
  ports {
    internal = 80
    external = var.port
  }
  volumes {
    container_path = "/usr/share/nginx/html"
    host_path      = abspath("${path.module}/pagepath")
    read_only      = true
  }
}

resource "local_file" "index_html" {
  content  = templatefile("${path.module}/conf.tpl", { message = var.message })
  filename = "${path.module}/pagepath/index.html"
}