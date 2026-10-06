#!/bin/bash
# Installs the local fedi replica units for this user; see README.md
set -euo pipefail
here=$(cd "$(dirname "$0")" && pwd)
mkdir -p ~/.config/containers/systemd ~/.config/systemd/user
ln -sf "$here/blr-today-fedi.container" ~/.config/containers/systemd/
ln -sf "$here/blr-today-fedi-mirror.service" "$here/blr-today-fedi-mirror.timer" ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user start blr-today-fedi.service
systemctl --user enable --now blr-today-fedi-mirror.timer
