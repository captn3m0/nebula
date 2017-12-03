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
3. ~Add traefik for proper proxying~

# Security Headers note

The following security headers are applied using traefik on all traefik frontend docker backends:

- HSTS: 2592000 seconds (1 week)
- Redirect HTTP->HTTPS
- contentTypeNosniff: true
- browserXSSFilter: true
- XFO: Allow-From muximux (TODO)
- referrerPolicy: no-referrer (TODO)
- X-Powered-By: Allomancy
- X-Server: BlackBox
- X-Clacks-Overhead "GNU Terry Pratchett" (TODO)

Currently waiting on traefik 1.5.0-rc2 to fix security specific headers issue (marked as TODO above).

## Upstream

Issues I've faced/reported as a result of this project:

1. Airsonic HTTPS proxying is broken. Reported: https://github.com/airsonic/airsonic/issues/641
2. Traefik docker backend security headers were broken with dashes. Reported at https://github.com/containous/traefik/issues/2493, and fixed by https://github.com/containous/traefik/pull/2496
3. Headphones dies repeatedly with no error logs. Yet-to-report.
4. Terraform doesn't parse mariadb version numbers. Report: https://github.com/terraform-providers/terraform-provider-mysql/issues/6. Got this fixed myself by filing a PR: https://github.com/hashicorp/go-version/pull/34
5. elibsrv didn't support ebook-convert, only mobigen. PR is at https://github.com/captn3m0/elibsrv/pull/1. I've to get this merged upstream for the next release.
6. ubooquity docker container doesn't let you set admin password: https://github.com/linuxserver/docker-ubooquity/issues/17
