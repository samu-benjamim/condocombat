# =============================================================================
# Frontend — Next.js no Render (imagem Docker do DockerHub)
# =============================================================================

resource "render_web_service" "frontend" {
  name   = "condocombat-frontend"
  plan   = "free"
  region = "oregon"

  runtime_source = {
    image = {
      image_url = "docker.io/${var.dockerhub_username}/condocombat-frontend:latest"
    }
  }

  env_vars = {
    NEXT_PUBLIC_API_URL = {
      value = "https://${render_web_service.backend.url}"
    }
    NODE_ENV = {
      value = "production"
    }
  }

  depends_on = [render_web_service.backend]
}

# ── Outputs ───────────────────────────────────────────────────────────────────

output "frontend_url" {
  description = "URL pública do frontend no Render"
  value       = "https://${render_web_service.frontend.url}"
}
