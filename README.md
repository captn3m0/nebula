# nebula

Where stars are born.

Manages the local infrastructure of my home server.

# modules

1. docker: to actually run the services
2. cloudflare: to manage the DNS
3. mysql: unused, but setup

Self-learning project for terraform

# Planned

1. Setup DigitalOcean
2. Add DO infrastructure via ansible
3. Add traefik for proper proxying

# Security Headers note

The following security headers are applied using traefik on all traefik frontend docker backends:

- HSTS: 2592000 seconds (1 week)
- Redirect HTTP->HTTPS
- contentTypeNosniff: true
- browserXSSFilter: true
- XFO: Allow-From muximux
- referrerPolicy: no-referrer
- X-Powered-By: Allomancy
- X-Server: BlackBox
- X-Clacks-Overhead "GNU Terry Pratchett"


Currently waiting on traefik 1.5.0-rc2 to fix security specific headers issue.
