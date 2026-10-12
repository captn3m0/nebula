# socks

SOCKS5 proxy (Dante sockd) reachable only on ceylon's Tailscale IP `100.105.210.25:1080`.

- `hostNetwork` so `external:` can bind outgoing connections to the anchor IP `10.47.0.6`.
- DigitalOcean routes anchor traffic out via the floating IP `139.59.48.222`.
- No auth: only tailnet devices can reach the listener.

Apply with `kubectl apply -k manifests/socks`, then check egress:

    curl -x socks5h://100.105.210.25:1080 https://ifconfig.co/ip
