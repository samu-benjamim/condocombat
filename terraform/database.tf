# =============================================================================
# Banco de Dados — Supabase PostgreSQL
# =============================================================================

# Importa o projeto existente no Supabase para o state do Terraform.
# O projeto foi criado no primeiro apply; o import block garante que runs
# subsequentes reconheçam o recurso sem tentar recriar.
import {
  to = supabase_project.condocombat
  id = "zzapgfhxkszxrwwqivwp"
}

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

