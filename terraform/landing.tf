# =============================================================================
# Landing Page — Netlify (deploy via CLI gerenciado pelo Terraform)
# =============================================================================
# O provider netlify/netlify não possui resource para criar/gerenciar sites
# e o data source exige team_slug (não disponível aqui).
# O deploy é feito via null_resource + local-exec: o CLI do Netlify aceita
# o slug do site diretamente no flag --site, sem precisar do ID interno.
# =============================================================================

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
        --site="${var.netlify_site_name}"
    EOT
  }
}

# ── Outputs ───────────────────────────────────────────────────────────────────

output "landing_url" {
  description = "URL pública da landing page no Netlify"
  value       = "https://${var.netlify_site_name}.netlify.app"
}
