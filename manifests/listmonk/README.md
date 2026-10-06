# listmonk

Self-hosted listmonk for the blr.today weekly email, sending through SES (`nebula/ses`).

- `configure.sh` sets up an installed listmonk: settings, SMTP, the Weekly list, a list role, the `web`
  (Netlify sign-up function) and `digest` (scheduler) API users, and the templates in `templates/`.
  It is safe to re-run. New API user tokens go to `$OUT/token-<name>`, or with `PASS_PREFIX` set,
  into pass at `$PASS_PREFIX-<name>` with the list and template ids (read by tofu for Netlify and the scheduler).
- `e2e.sh` runs listmonk, Postgres and Mailpit (in place of SES) in a podman pod, then drives the real
  Netlify function from `../blr-today-website` and `scheduler digest --send` from `../scheduler`.
  `KEEP=1 ./e2e.sh` leaves the pod up: listmonk on :19000, Mailpit on :18025.

Choices live on each subscriber as `attribs.digest = {always: {...}, never: {...}}`. The scheduler
renders every event with a template check on those, so one campaign serves everyone.
