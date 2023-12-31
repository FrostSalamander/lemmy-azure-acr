resource "azurerm_container_registry_task" "lemmy_nginx" {
  name                  = "build-lemmy-nginx"
  container_registry_id = azurerm_container_registry.acr.id
  platform {
    os = "Linux"
  }

  docker_step {
    dockerfile_path      = "Dockerfile"
    context_path         = "https://github.com/FrostSalamander/docker-lemmy-nginx#main"
    context_access_token = var.pat_token
    image_names          = ["lemmy-nginx:{{.Run.ID}}"]
  }

  source_trigger {
    name           = "build-lemmy-nginx"
    events         = ["commit"]
    repository_url = "https://github.com/FrostSalamander/docker-lemmy-nginx.git"
    source_type    = "Github"
    branch         = "main"

    authentication {
      token = var.pat_token
      token_type = "PAT"
    }
  }
}