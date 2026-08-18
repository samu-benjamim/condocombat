# =============================================================================
# Variáveis de Input
# =============================================================================
# Valores sensíveis são passados via TF_VAR_* ou .tfvars (nunca commitados).
# No GitHub Actions, cada variável corresponde a um secret do repositório.
# =============================================================================

# ── Supabase ─────────────────────────────────────────────────────────────────

variable "supabase_access_token" {
  description = "Token de acesso pessoal do Supabase (Settings → Access Tokens)"
  type        = string
  sensitive   = true
}

variable "supabase_org_id" {
  description = "ID da organização no Supabase (Settings → General)"
  type        = string
}

variable "supabase_db_password" {
  description = "Senha do banco de dados PostgreSQL no Supabase"
  type        = string
  sensitive   = true
}

# ── Render ────────────────────────────────────────────────────────────────────

variable "render_api_key" {
  description = "Chave de API do Render (Account → API Keys)"
  type        = string
  sensitive   = true
}

variable "render_owner_id" {
  description = "ID do owner no Render (usr-...)"
  type        = string
}

# ── Netlify ───────────────────────────────────────────────────────────────────

variable "netlify_auth_token" {
  description = "Token de acesso pessoal do Netlify (User Settings → Applications)"
  type        = string
  sensitive   = true
}

variable "netlify_site_name" {
  description = "Slug/nome do site no Netlify"
  type        = string
  default     = "condocombat-landing-samuelsantos"
}

# ── Aplicação ─────────────────────────────────────────────────────────────────

variable "dockerhub_username" {
  description = "Usuário no DockerHub (dono das imagens)"
  type        = string
  default     = "samubenjamim"
}

variable "backend_secret_key" {
  description = "SECRET_KEY para assinatura de tokens JWT do backend"
  type        = string
  sensitive   = true
}
