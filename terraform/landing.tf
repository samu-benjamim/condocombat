# =============================================================================
# Landing Page — Netlify
# =============================================================================
# O provider netlify/netlify expõe "netlify_site" apenas como DATA SOURCE
# (consulta de site existente), não como resource de criação.
# O site já existe na conta Netlify — consultamos o ID e fazemos o deploy
# via Netlify CLI dentro de um null_resource (local-exec).
# =============================================================================

# Lê o site existente para obter o ID interno do Netlify
data "netlify_site" "landing" {
  name = var.netlify_site_name
}

# Faz o deploy dos arquivos estáticos de landing/dist
resource "null_resource" "deploy_landing" {
  triggers = {
    # Força redeploy a cada terraform apply no CD
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = <<-EOT
      npm install -g netlify-cli --silent
      netlify deploy \
        --dir=landing/dist \
        --prod \
        --auth="${var.netlify_auth_token}" \
        --site="${data.netlify_site.landing.id}"
    EOT
  }
}

# ── Outputs ───────────────────────────────────────────────────────────────────

output "landing_url" {
  description = "URL pública da landing page no Netlify"
  value       = "https://${var.netlify_site_name}.netlify.app"
}
