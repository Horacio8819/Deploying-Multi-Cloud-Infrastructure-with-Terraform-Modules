provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "terraform-nginx"
  restart = "on-failure"

  ports {
    internal = 80
    external = 8070
  }
  labels {
    label = "managed-by"
    value = "terraform"
  }
}