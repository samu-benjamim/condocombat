# =============================================================================
# Landing Page — Netlify (deploy do artefato landing/dist)
# =============================================================================

# Gerencia a configuração do site (cria se não existir, importa se já existe)
resource "netlify_site" "landing" {
  name = var.netlify_site_name

  repo {
    provider = "manual"
  }
}

# Publica os arquivos estáticos de landing/dist via Netlify CLI.
# O null_resource garante que o deploy ocorre sempre que o terraform apply roda,
# mantendo o conteúdo sincronizado com o artefato gerado na etapa de CI.
resource "null_resource" "deploy_landing" {
  triggers = {
    # Força redeploy a cada apply (útil no CD para garantir o artefato mais recente)
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = <<-EOT
      npm install -g netlify-cli --silent
      netlify deploy \
        --dir=landing/dist \
        --prod \
        --auth="${var.netlify_auth_token}" \
        --site="${netlify_site.landing.id}"
    EOT
  }

  depends_on = [netlify_site.landing]
}

# ── Outputs ───────────────────────────────────────────────────────────────────

output "landing_url" {
  description = "URL pública da landing page no Netlify"
  value       = "https://${netlify_site.landing.name}.netlify.app"
}
