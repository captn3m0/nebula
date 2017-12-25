# nebula

>Where stars are born.

Manages the local infrastructure of my home server. I'm also doing blog posts around the same:

1. [Part 1, Hardware](https://captnemo.in/blog/2017/09/17/home-server-build/)
2. [Part 2, Terraform/Docker](https://captnemo.in/blog/2017/11/09/home-server-update/)

# modules

1. docker: to actually run the services
2. cloudflare: to manage the DNS
3. mysql: unused, but setup

Self-learning project for terraform/docker

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

~~Currently waiting on traefik 1.5.0-rc2 to fix security specific headers issue (marked as TODO above).~~ (Now resolved with new traefik release)

## Upstream

Issues I've faced/reported as a result of this project:

1. Airsonic HTTPS proxying is broken. Reported: https://github.com/airsonic/airsonic/issues/641. Turned out to be a known issue: https://github.com/airsonic/airsonic/issues/594.
2. Traefik docker backend security headers were broken with dashes. Reported at https://github.com/containous/traefik/issues/2493, and fixed by https://github.com/containous/traefik/pull/2496
3. Headphones dies repeatedly with no error logs. Yet-to-report.
4. Terraform doesn't parse mariadb version numbers. Report: https://github.com/terraform-providers/terraform-provider-mysql/issues/6. Got this fixed myself by filing a PR: https://github.com/hashicorp/go-version/pull/34. Another PR pending in the [provider](https://github.com/terraform-providers/terraform-provider-mysql/pull/27) to bump the go-version dependency.
5. `elibsrv` didn't support ebook-convert, only mobigen. PR is at https://github.com/captn3m0/elibsrv/pull/1. I've to get this merged upstream for the next release.
6. `ubooquity` docker container doesn't let you set admin password: https://github.com/linuxserver/docker-ubooquity/issues/17. (Couldn't reproduce, closed)
7. Traefik customresponseheaders can't contain colons on the docker backend: https://github.com/containous/traefik/issues/2517. Fixed with https://github.com/containous/traefik/pull/2509
8. Traefik Security headers don't overwrite upstream headers: https://github.com/containous/traefik/issues/2618

# Plumbing

Their is a lot of additional infrastructure that is _not-yet_ part of this repo. This includes:

1. The Digital Ocean droplet running DNSCrypt and simpleproxy to proxy over a openvpn connection to this box.
2. openbox, kodi configuration to run on boot along with the Steam Controller for the HTPC setup
3. Docker main configuration with half-baked CA setup
4. btrfs-backed subvolumes and snapshotting for most things in /mnt/xwing/ (in-progress)
