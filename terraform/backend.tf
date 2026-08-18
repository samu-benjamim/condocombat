# =============================================================================
# Backend — FastAPI no Render (imagem Docker do DockerHub)
# =============================================================================

resource "render_web_service" "backend" {
  name   = "condocombat-backend"
  plan   = "free"
  region = "oregon"

  runtime_source = {
    image = {
      image_url = "docker.io/${var.dockerhub_username}/condocombat-backend:latest"
    }
  }

  env_vars = {
    SECRET_KEY = {
      value = var.backend_secret_key
    }
    DATABASE_URL = {
      value = local.database_url
    }
    # URL previsível do Render: {nome-do-serviço}.onrender.com
    # Usar referência direta criaria ciclo (backend↔frontend), então usamos o padrão fixo.
    CORS_ORIGINS = {
      value = "https://condocombat-frontend.onrender.com"
    }
  }

  depends_on = [supabase_project.condocombat]
}

# ── Outputs ───────────────────────────────────────────────────────────────────

output "backend_url" {
  description = "URL pública do backend no Render"
  value       = "https://${render_web_service.backend.url}"
}
