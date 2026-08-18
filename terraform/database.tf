# =============================================================================
# Banco de Dados — Supabase PostgreSQL
# =============================================================================

resource "supabase_project" "condocombat" {
  organization_id   = var.supabase_org_id
  name              = "condocombat"
  database_password = var.supabase_db_password
  region            = "sa-east-1"
}

# ── Locals ────────────────────────────────────────────────────────────────────
# URL de conexão direta (session mode) — compatível com asyncpg e Alembic.
# Supavisor (transaction mode, porta 6543) não suporta SET e LISTEN/NOTIFY.

locals {
  database_url = "postgresql+asyncpg://postgres:${var.supabase_db_password}@db.${supabase_project.condocombat.id}.supabase.co:5432/postgres"
}

# ── Outputs ───────────────────────────────────────────────────────────────────

output "supabase_project_id" {
  description = "ID do projeto Supabase"
  value       = supabase_project.condocombat.id
}

output "supabase_anon_key" {
  description = "Chave anônima pública do Supabase"
  value       = supabase_project.condocombat.anon_key
  sensitive   = true
}
