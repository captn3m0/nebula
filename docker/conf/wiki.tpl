port: 3000
db:
  type: postgres
  host: postgres
  port: 5432
  user: wikijs
  db: wikijs
  pass: ${DB_PASSWORD}
ssl:
  enabled: false
bindIP: 0.0.0.0
logLevel: silly
offline: true
ha: false
dataPath: /data
