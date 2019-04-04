vault {
  renew_token = true
  vault_agent_token_file = "/home/vault/.vault-token"
  retry {
    backoff = "1s"
  }
}

template {
  destination = "/etc/secrets/vault.html"
  contents = <<EOH
  <html>
  <body>
  <p>Some secrets:</p>
  {{- with secret "secret/myapp/config" }}
  <ul>
  <li><pre>username: {{ .Data.username }}</pre></li>
  <li><pre>password: {{ .Data.password }}</pre></li>
  </ul>
  {{ end }}
  </body>
  </html>  
  EOH
}
