resource "azurerm_container_registry_task" "lemmy-ui" {
  name                  = "build-lemmy-ui"
  container_registry_id = azurerm_container_registry.acr.id
  platform {
    os = "Linux"
  }

  docker_step {
    dockerfile_path      = "Dockerfile"
    context_path         = "https://github.com/FrostSalamander/lemmy-ui#docker-debug"
    context_access_token = var.pat_token
    image_names          = ["lemmy:{{.Run.ID}}"]
  }

  source_trigger {
    name           = "build-lemmy-ui"
    events         = ["commit"]
    repository_url = "https://github.com/FrostSalamander/docker-lemmy.git"
    source_type    = "Github"
    branch         = "docker-debug"

    authentication {
      token = var.pat_token
      token_type = "PAT"
    }
  }
}