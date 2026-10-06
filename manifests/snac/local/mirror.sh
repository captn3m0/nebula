#!/bin/bash
# Mirrors the Bluesky firehose to the local snac replica with the latest events.db
set -euo pipefail
home=${BLR_FEDI_HOME:-$HOME/.local/share/blr-today-fedi}
ingest=${INGEST:-$HOME/projects/personal/ingest}
cd "$home"
id=$(gh api "repos/blr-today/ingest/actions/artifacts?name=events-db&per_page=20" \
  --jq '[.artifacts[] | select(.expired | not) | select(.workflow_run.head_branch == "main")] | sort_by(.created_at) | last | .id // empty')
if [ -n "$id" ]; then
  gh api "repos/blr-today/ingest/actions/artifacts/$id/zip" > events.zip
  unzip -o -q events.zip events.db
else
  gh release download --repo blr-today/dataset --pattern events.db --clobber
fi
set -a
. "$home/tokens.env"
set +a
cd "$ingest"
PYTHONPATH=src exec uv run --frozen python src/fedi.py --db "$home/events.db" --ledger "$home/ledger/fedi.json" "$@"
