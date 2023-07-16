resource "azurerm_container_registry_task" "helloworld_nginx" {
  name                  = "build-helloworld-nginx"
  container_registry_id = azurerm_container_registry.acr.id
  platform {
    os = "Linux"
  }

  docker_step {
    dockerfile_path      = "Dockerfile"
    context_path         = "https://github.com/FrostSalamander/docker-nginx-helloworld#main"
    context_access_token = var.pat_token
    image_names          = ["helloworld-nginx:{{.Run.ID}}"]
  }

  source_trigger {
    name           = "build-helloworld-nginx"
    events         = ["commit"]
    repository_url = "https://github.com/FrostSalamander/docker-nginx-helloworld.git"
    source_type    = "Github"
    branch         = "main"

    authentication {
      token = var.pat_token
      token_type = "PAT"
    }
  }
}