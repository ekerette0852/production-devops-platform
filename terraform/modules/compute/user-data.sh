#!/bin/bash
set -euxo pipefail

dnf update -y
dnf install -y docker

systemctl enable --now docker
systemctl enable --now amazon-ssm-agent

mkdir -p /opt/production-web

cat > /opt/production-web/index.html <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <title>Production DevOps Platform</title>

  <style>
    * {
      box-sizing: border-box;
    }

    body {
      margin: 0;
      min-height: 100vh;
      display: grid;
      place-items: center;
      padding: 24px;
      font-family: Arial, Helvetica, sans-serif;
      background:
        radial-gradient(circle at top left, #243b55, transparent 45%),
        linear-gradient(135deg, #0f172a, #111827);
      color: #f8fafc;
    }

    .container {
      width: 100%;
      max-width: 900px;
      padding: 56px;
      border: 1px solid rgba(255, 255, 255, 0.14);
      border-radius: 24px;
      background: rgba(15, 23, 42, 0.82);
      box-shadow: 0 24px 80px rgba(0, 0, 0, 0.45);
      text-align: center;
    }

    .status {
      display: inline-block;
      margin-bottom: 24px;
      padding: 8px 16px;
      border-radius: 999px;
      background: rgba(34, 197, 94, 0.15);
      color: #86efac;
      font-weight: bold;
    }

    h1 {
      margin: 0 0 18px;
      font-size: clamp(2.4rem, 7vw, 5rem);
      line-height: 1;
    }

    .subtitle {
      margin: 0 auto 38px;
      max-width: 680px;
      color: #cbd5e1;
      font-size: 1.2rem;
      line-height: 1.7;
    }

    .stack {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      gap: 12px;
    }

    .stack span {
      padding: 10px 16px;
      border: 1px solid rgba(255, 255, 255, 0.12);
      border-radius: 10px;
      background: rgba(255, 255, 255, 0.06);
    }

    footer {
      margin-top: 40px;
      color: #94a3b8;
    }
  </style>
</head>

<body>
  <main class="container">
    <div class="status">● Platform Online</div>

    <h1>Production DevOps Platform</h1>

    <p class="subtitle">
      A production-style AWS platform provisioned with reusable Terraform
      modules and running a containerized NGINX application on private
      infrastructure behind an Application Load Balancer.
    </p>

    <div class="stack">
      <span>AWS</span>
      <span>Terraform</span>
      <span>EC2</span>
      <span>Docker</span>
      <span>NGINX</span>
      <span>Application Load Balancer</span>
      <span>Systems Manager</span>
    </div>

    <footer>
      Built by Jesse Akpanyah
    </footer>
  </main>
</body>
</html>
EOF

docker pull nginx:1.30.4-alpine

docker rm -f production-web 2>/dev/null || true

docker run -d \
  --name production-web \
  --restart unless-stopped \
  -p 80:80 \
  -v /opt/production-web/index.html:/usr/share/nginx/html/index.html:ro \
  nginx:1.30.4-alpine
