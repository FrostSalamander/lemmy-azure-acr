resource "azurerm_container_registry_task" "lemmy" {
  name                  = "build-lemmy"
  container_registry_id = azurerm_container_registry.acr.id
  platform {
    os = "Linux"
  }

  docker_step {
    dockerfile_path      = "Dockerfile"
    context_path         = "https://github.com/FrostSalamander/docker-lemmy#main"
    context_access_token = var.pat_token
    image_names          = ["lemmy:{{.Run.ID}}"]
  }

  source_trigger {
    name           = "build-lemmy"
    events         = ["commit"]
    repository_url = "https://github.com/FrostSalamander/docker-lemmy.git"
    source_type    = "Github"
    branch         = "main"

    authentication {
      token = var.pat_token
      token_type = "PAT"
    }
  }
}