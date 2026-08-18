# =============================================================================
# Providers — Supabase · Render · Netlify
# =============================================================================

terraform {
  required_version = ">= 1.10.0"

  required_providers {
    supabase = {
      source  = "supabase/supabase"
      version = "~> 1.0"
    }
    render = {
      source  = "render-oss/render"
      version = "~> 1.6"
    }
    netlify = {
      source  = "netlify/netlify"
      version = "~> 0.1"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

provider "supabase" {
  access_token = var.supabase_access_token
}

provider "render" {
  api_key  = var.render_api_key
  owner_id = var.render_owner_id
}

provider "netlify" {
  token = var.netlify_auth_token
}
