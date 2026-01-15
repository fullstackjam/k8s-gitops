data "cloudflare_zone" "zone" {
  filter = {
    name = "fullstackjam.com"
  }
}

data "cloudflare_api_token_permission_groups_list" "all" {}

locals {
  api_token_zone_permissions_groups_map = {
    for perm in data.cloudflare_api_token_permission_groups_list.all.result :
    perm.name => perm.id
    if contains(perm.scopes, "com.cloudflare.api.account.zone")
  }
}

resource "cloudflare_zero_trust_tunnel_cloudflared" "homelab" {
  account_id = var.cloudflare_account_id
  name       = "homelab"
  config_src = "cloudflare"
}

data "cloudflare_zero_trust_tunnel_cloudflared_token" "homelab" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.homelab.id
}

resource "cloudflare_zero_trust_tunnel_cloudflared_config" "homelab" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.homelab.id
  config = {
    ingress = [
      {
        hostname = "*.fullstackjam.com"
        service  = "https://ingress-nginx-controller.ingress-nginx"
        origin_request = {
          no_tls_verify          = true
          keep_alive_connections = 100
          keep_alive_timeout     = 30
        }
      },
      {
        service = "http_status:404"
      }
    ]
  }
}

# Not proxied, not accessible. Just a record for auto-created CNAMEs by external-dns.
resource "cloudflare_dns_record" "tunnel" {
  zone_id = data.cloudflare_zone.zone.zone_id
  type    = "CNAME"
  name    = "homelab-tunnel"
  content = "${cloudflare_zero_trust_tunnel_cloudflared.homelab.id}.cfargotunnel.com"
  proxied = false
  ttl     = 1 # Auto
}

resource "kubernetes_secret_v1" "cloudflared_credentials" {
  metadata {
    name      = "cloudflared-credentials"
    namespace = "cloudflared"

    annotations = {
      "app.kubernetes.io/managed-by" = "Terraform"
    }
  }

  data = {
    "tunnel-token" = data.cloudflare_zero_trust_tunnel_cloudflared_token.homelab.token
  }
}

resource "cloudflare_api_token" "external_dns" {
  name = "homelab_external_dns"

  policies = [{
    effect = "allow"
    permission_groups = [
      { id = local.api_token_zone_permissions_groups_map["Zone Read"] },
      { id = local.api_token_zone_permissions_groups_map["DNS Write"] }
    ]
    resources = jsonencode({
      "com.cloudflare.api.account.zone.*" = "*"
    })
  }]
}

resource "kubernetes_secret_v1" "external_dns_token" {
  metadata {
    name      = "cloudflare-api-token"
    namespace = "external-dns"

    annotations = {
      "app.kubernetes.io/managed-by" = "Terraform"
    }
  }

  data = {
    "value" = cloudflare_api_token.external_dns.value
  }
}

resource "cloudflare_api_token" "cert_manager" {
  name = "homelab_cert_manager"

  policies = [{
    effect = "allow"
    permission_groups = [
      { id = local.api_token_zone_permissions_groups_map["Zone Read"] },
      { id = local.api_token_zone_permissions_groups_map["DNS Write"] }
    ]
    resources = jsonencode({
      "com.cloudflare.api.account.zone.*" = "*"
    })
  }]
}

resource "kubernetes_secret_v1" "cert_manager_token" {
  metadata {
    name      = "cloudflare-api-token"
    namespace = "cert-manager"

    annotations = {
      "app.kubernetes.io/managed-by" = "Terraform"
    }
  }

  data = {
    "api-token" = cloudflare_api_token.cert_manager.value
  }
}
