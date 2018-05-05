# nebula

![Nebula header image](https://cdn.spacetelescope.org/archives/images/thumb700x/heic0707a.jpg)

>Where stars are born.

Manages the local infrastructure of my home server. I'm also doing blog posts around the same:

1. [Part 1, Hardware](https://captnemo.in/blog/2017/09/17/home-server-build/)
2. [Part 2, Terraform/Docker](https://captnemo.in/blog/2017/11/09/home-server-update/)
3. [Part 3, Learnings](https://captnemo.in/blog/2017/12/18/home-server-learnings/)
4. [Part 4, Migrating from Google (and more)](https://captnemo.in/blog/2017/12/31/migrating-from-google/)
5. [Part 5, Networking](https://captnemo.in/blog/2018/04/22/home-server-networking/)

The canonical URL for this repo is https://git.captnemo.in/nemo/nebula/. A mirror is maintained on GitHub at <https://github.com/captn3m0/nebula>

# modules

1. docker: to actually run the services. Catch-all for miscellaneous containers
2. cloudflare: to manage the DNS.
3. mysql: to create mysql users and databases.
4. media: Media related containers (Jackett, Lidarr, Radarr, Sonarr)
5. Monitoring: Monitoring related resources (Cadvisor, Grafana, NodeExporter, Prometheus, Transmission-Exporter)
6. Gitea: Just git.captnemo.in
7. tt-rss: Tiny-Tiny RSS Web reader
8. Radicale: CardDav/CalDav webserver

Self-learning project for terraform/docker.

# Planned

1. ~Setup DigitalOcean~
2. Add DO infrastructure via ansible
3. ~Add traefik for proper proxying~
4. Maybe add docker swarm (or k8s?) across both the servers. Might setup the k8s API on the Raspberry Pi.

# Service List

Currently running the following (all links are to the `store.docker.com` links for the docker images that I'm using:

| image                          | tag     | size | category/module |
|--------------------------------|---------|------|-----------------|
| prom/node-exporter             | v0.15.2 | 22.8 | monitoring      |
| redis                          | alpine  | 27.8 | gitea           |
| linuxserver/transmission       | latest  | 43.9 | media           |
| traefik                        | 1.6     | 51.8 | docker          |
| google/cadvisor                | latest  | 62.2 | monitoring      |
| odarriba/timemachine           | latest  | 77.2 | backup          |
| gitea/gitea                    | 1.4     | 77.4 | gitea           |
| linuxserver/heimdall           | latest  | 101  | general         |
| linuxserver/tt-rss             | latest  | 108  | tt-rss          |
| prom/prometheus                | latest  | 113  | monitoring      |
| linuxserver/ubooquity          | latest  | 114  | docker          |
| captn3m0/speedtest-exporter    | alpine  | 115  | monitoring      |
| tomsquest/docker-radicale      | latest  | 130  | radicale        |
| linuxserver/lychee             | latest  | 154  | lychee          |
| linuxserver/resilio-sync       | latest  | 167  | resilio         |
| emby/embyserver                | latest  | 202  | media           |
| linuxserver/airsonic           | latest  | 239  | media           |
| grafana/grafana                | latest  | 301  | monitoring      |
| requarks/wiki                  | latest  | 317  | wiki            |
| percona/percona-server-mongodb | latest  | 321  | wiki            |
| mariadb                        | 10.3    | 402  | db              |
| linuxserver/jackett            | latest  | 556  | media           |
| linuxserver/sonarr             | latest  | 562  | media           |
| linuxserver/radarr             | latest  | 566  | media           |
| linuxserver/lidarr             | latest  | 574  | media           |

## Docker Notes
- Lots of the above images are from the excellent [LinuxServer.io](https://www.linuxserver.io), and they're doing great work :+1:
- Most images are running the latest beta (if available) or stable versions.
- Traefik is running with wildcard certificates.

## Upstream

Issues I've faced/reported as a result of this project:

1. Airsonic HTTPS proxying is broken. Reported: https://github.com/airsonic/airsonic/issues/641. Turned out to be a known issue: https://github.com/airsonic/airsonic/issues/594. Now fixed.
2. Traefik docker backend security headers were broken with dashes. I [reported it here](https://github.com/containous/traefik/issues/2493), and fixed by https://github.com/containous/traefik/pull/2496 :white_check_mark:
3. Headphones dies repeatedly with no error logs. Yet-to-report. (Already reported, fails due to classical artists)
4. Terraform doesn't parse mariadb version numbers. Report: https://github.com/terraform-providers/terraform-provider-mysql/issues/6. Filed a [PR to fix](https://github.com/hashicorp/go-version/pull/34) and [to bump the go-version dependency](https://github.com/terraform-providers/terraform-provider-mysql/pull/27) :white_check_mark:
5. `elibsrv` didn't support ebook-convert, only mobigen. PR is at https://github.com/captn3m0/elibsrv/pull/1. Merged to `elibsrv` trunk, will be part of next release.
6. `ubooquity` docker container doesn't let you set admin password: https://github.com/linuxserver/docker-ubooquity/issues/17. (Couldn't reproduce, closed) :white_check_mark:
7. Traefik customresponseheaders can't contain colons on the docker backend: https://github.com/containous/traefik/issues/2517. Fixed with https://github.com/containous/traefik/pull/2509 :white_check_mark:
8. Traefik Security headers don't overwrite upstream headers: https://github.com/containous/traefik/issues/2618 :white_check_mark:
9. Transmission exporter broke with different data types while unmarshalling JSON in go. I filed a PR https://github.com/metalmatze/transmission-exporter/pull/2 :white_check_mark:
10. Radarr official docker container was [running a very old `mediainfo`](https://github.com/Radarr/Radarr/issues/2668#issuecomment-376310514). [Filed a fix to upgrade `mediainfo` on the official radarr image](https://github.com/linuxserver/docker-baseimage-mono/pull/3) :white_check_mark:
11. Patched the [speedtest-exporter](https://github.com/stefanwalther/speedtest-exporter/pull/7) to use Alpine and upgraded Node.JS for a smaller updated build.
12. Faced (4) above again because mariadb decided to add `:` in the version response. [Workaround was to force set `--version=10.3-mariadb`](https://git.captnemo.in/nemo/nebula/commit/5f47a08bb55eea2c708c41668657ac1efa84c72a)
13. Reported [2 critical security issues in Abstruse CI](https://github.com/bleenco/abstruse/issues/363). :white_check_mark:

# Plumbing

Their is a lot of additional infrastructure that is _not-yet_ part of this repo. This includes:

1. The Digital Ocean droplet running DNSCrypt and simpleproxy to proxy over a openvpn connection to this box.
2. openbox, kodi configuration to run on boot along with the Steam Controller for the HTPC setup
3. Docker main configuration with half-baked CA setup
4. btrfs-backed subvolumes and snapshotting for most things in /mnt/xwing/ (in-progress)
5. User-creation on the main server. (I'm using a common user for media applications and specific users for other applications)

# License

All code in this repository is shared under the [MIT License](https://nemo.mit-license.org/).
