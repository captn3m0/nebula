; This file lists the default values used by Gitea
; Copy required sections to your own app.ini (default is custom/conf/app.ini)
; and modify as needed.
; See the cheatsheet at https://docs.gitea.io/en-us/config-cheat-sheet/
; A sample file with all configuration documented is at https://github.com/go-gitea/gitea/blob/main/custom/conf/app.example.ini

; App name that shows on every page title
APP_NAME = Nemo's code
RUN_MODE = prod
RUN_USER = git
WORK_PATH=/data/gitea

[repository]
ROOT = /data/git/repositories
USE_COMPAT_SSH_URI = false

[repository.upload]
TEMP_PATH = /data/gitea/uploads

[ui]

;; Number of issues that are displayed on one page
ISSUE_PAGING_NUM = 20

; Value of `theme-color` meta tag, used by Android >= 5.0
; An invalid color like "none" or "disable" will have the default style
; More info: https://developers.google.com/web/updates/2014/11/Support-for-theme-color-in-Chrome-39-for-Android
THEME_COLOR_META_TAG = `#192a56`
; Max size of files to be displayed (defaults is 8MiB)
MAX_DISPLAY_FILE_SIZE = 1000000
; Whether show the user email in the Explore Users page
SHOW_USER_EMAIL = false

[ui.admin]
; Number of users that are showed in one page
USER_PAGING_NUM = 50
; Number of repos that are showed in one page
REPO_PAGING_NUM = 50
; Number of notices that are showed in one page
NOTICE_PAGING_NUM = 25
; Number of organization that are showed in one page
ORG_PAGING_NUM = 50

;; Whether to only show relevant repos on the explore page when no keyword is specified and default sorting is used.
;; A repo is considered irrelevant if it's a fork or if it has no metadata (no description, no icon, no topic).

ONLY_SHOW_RELEVANT_REPOS = true

[ui.user]
; Number of repos that are showed in one page
REPO_PAGING_NUM = 15

[ui.meta]
AUTHOR = Nemo
DESCRIPTION = Nemo's self-hosted code
KEYWORDS = git, captnemo, git.captnemo.in, piratecoders

[markdown]
; Enable hard line break extension
ENABLE_HARD_LINE_BREAK = false
; List of custom URL-Schemes that are allowed as links when rendering Markdown
; for example git,magnet
CUSTOM_URL_SCHEMES = git,magnet,steam,irc,slack
FILE_EXTENSIONS = .md,.markdown,.mdown,.mkd

;; Enables math inline and block detection
ENABLE_MATH = true

; Define allowed algorithms and their minimum key length (use -1 to disable a type)
[ssh.minimum_key_sizes]
ED25519 = 256
ECDSA = 256
RSA = 2048
DSA = 1024

[lfs]
PATH=/data/gitea/lfs

[server]
APP_DATA_PATH    = /data/gitea
HTTP_PORT        = 3000
ROOT_URL         = https://git.captnemo.in/
DISABLE_SSH      = true
DOMAIN           = git.captnemo.in
LFS_START_SERVER = true
LFS_JWT_SECRET   = "${lfs-jwt-secret}"
OFFLINE_MODE     = true
LANDING_PAGE     = explore
MINIMUM_KEY_SIZE_CHECK = true

# Uses the Mozilla Modern SSH Config params
SSH_SERVER_CIPHERS = chacha20-poly1305@openssh.com, aes256-gcm@openssh.com, aes128-gcm@openssh.com, aes256-ctr, aes192-ctr, aes128-ctr
SSH_SERVER_KEY_EXCHANGES = curve25519-sha256@libssh.org, ecdh-sha2-nistp521, ecdh-sha2-nistp384, ecdh-sha2-nistp256, diffie-hellman-group-exchange-sha256
SSH_SERVER_MACS = hmac-sha2-512-etm@openssh.com, hmac-sha2-256-etm@openssh.com, umac-128-etm@openssh.com, hmac-sha2-512, hmac-sha2-256, umac-128@openssh.com

DISABLE_ROUTER_LOG = true
ENABLE_GZIP = true
[database]

; TODO
; ; Either "mysql", "postgres", "mssql" or "sqlite3", it's your choice
DB_TYPE = sqlite3
HOST = mariadb:3306
NAME = gitea
USER = gitea
; PASSWD = "mysql-password"
; ; For "postgres" only, either "disable", "require" or "verify-full"
; SSL_MODE = disable
; ; For "sqlite3" and "tidb", use absolute path when you start as service
PATH = /data/gitea/gitea.db
; ; For "sqlite3" only. Query timeout
SQLITE_TIMEOUT = 500
; ; For iterate buffer, default is 50
; ITERATE_BUFFER_SIZE = 50
; Show the database generated SQL
LOG_SQL = false
SQLITE_JOURNAL_MODE = WAL

[picture]
AVATAR_UPLOAD_PATH      = /data/gitea/avatars
DISABLE_GRAVATAR        = true
ENABLE_FEDERATED_AVATAR = false

[indexer]
ISSUE_INDEXER_PATH = indexers/issues.bleve
; repo indexer by default disabled, since it uses a lot of disk space
REPO_INDEXER_ENABLED = true
REPO_INDEXER_PATH = indexers/repos.bleve
MAX_FILE_SIZE = 1048576

[queue.issue_indexer]
LENGTH = 100

[admin]
; Disable regular (non-admin) users to create organizations
DISABLE_REGULAR_ORG_CREATION = false

[security]
INSTALL_LOCK = true
LOGIN_REMEMBER_DAYS = 30
MIN_PASSWORD_LENGTH = 10
IMPORT_LOCAL_PATHS = true
DISABLE_GIT_HOOKS = true
SECRET_KEY     = "${secret_key}"
INTERNAL_TOKEN = "${internal_token}"

[service]
; ; More detail: https://github.com/gogits/gogs/issues/165
; ENABLE_REVERSE_PROXY_AUTHENTICATION = false
; ENABLE_REVERSE_PROXY_AUTO_REGISTRATION = false

; ; Time limit to confirm account/email registration
ACTIVE_CODE_LIVE_MINUTES = 15
; ; Time limit to confirm forgot password reset process
RESET_PASSWD_CODE_LIVE_MINUTES = 30
REGISTER_EMAIL_CONFIRM            = true
ENABLE_NOTIFY_MAIL                = true
DISABLE_REGISTRATION              = true
; ; Enable captcha validation for registration
ENABLE_CAPTCHA                    = true
REQUIRE_EXTERNAL_REGISTRATION_CAPTCHA = true
CAPTCHA_TYPE = image
; ; User must sign in to view anything.
REQUIRE_SIGNIN_VIEW               = false
; ; Default value for KeepEmailPrivate
; ; New user will get the value of this setting copied into their profile
DEFAULT_KEEP_EMAIL_PRIVATE        = true
; ; Default value for AllowCreateOrganization
; ; New user will have rights set to create organizations depending on this setting
DEFAULT_ALLOW_CREATE_ORGANIZATION = true
DEFAULT_ENABLE_TIMETRACKING       = false
DEFAULT_ALLOW_ONLY_CONTRIBUTORS_TO_TRACK_TIME = true
; ; Default value for the domain part of the user's email address in the git log
; ; if he has set KeepEmailPrivate true. The user's email replaced with a
; ; concatenation of the user name in lower case, "@" and NO_REPLY_ADDRESS.
NO_REPLY_ADDRESS                  = noreply.example.org
ENABLE_REVERSE_PROXY_AUTHENTICATION = false
ENABLE_REVERSE_PROXY_AUTO_REGISTRATION = false

[mailer]
ENABLED = true
FROM = git@captnemo.in
USER = git@captnemo.in
PASSWD = ${smtp_password}
PROTOCOL = smtps
SMTP_ADDR = smtp.migadu.com
SMTP_PORT = 465
SEND_AS_PLAIN_TEXT = true
SUBJECT_PREFIX = "[git.captnemo.in] "

[cache]
ADAPTER = redis
HOST = "network=tcp,addr=gitea-redis:6379,db=0,pool_size=100,idle_timeout=180"

[session]
; ; Either "memory", "file", or "redis", default is "memory"
PROVIDER = redis
; Provider config options
; redis: network=tcp,addr=:6379,password=macaron,db=0,pool_size=100,idle_timeout=180
PROVIDER_CONFIG = "network=tcp,addr=gitea-redis:6379,db=1,pool_size=100,idle_timeout=180"
; ; If you use session in https only, default is false
COOKIE_SECURE = true
; SameSite settings. Either "none", "lax", or "strict"
SAME_SITE = strict

[migrations]
ALLOWED_DOMAINS = github.com,api.github.com
ALLOW_LOCALNETWORKS = false


[attachment]
; ; Whether attachments are enabled. Defaults to `true`
ENABLE = true
; ; One or more allowed types, e.g. image/jpeg|image/png
ALLOWED_TYPES = image/jpeg|image/png|application/zip|application/gzip|application/pdf|text/csv
; ; Max size of each file. Defaults to 32MB
MAX_SIZE = 200
; ; Max number of files per upload. Defaults to 10
MAX_FILES = 10

[log]
; Either "console", "file", "conn", "smtp" or "database", default is "console"
; Use comma to separate multiple modes, e.g. "console, file"
MODE = console
; Buffer length of the channel, keep it as it is if you don't know what it is.
BUFFER_LEN = 10000
; Either "Trace", "Debug", "Info", "Warn", "Error", "Critical", default is "Trace"
LEVEL = Warn
REDIRECT_MACARON_LOG = true
ROUTER_LOG_LEVEL = Critical
logger.access.MODE=,
logger.xorm.MODE=,

[cron]
; Enable running cron tasks periodically.
ENABLED = true
; ; Run cron tasks when Gitea starts.
RUN_AT_START = false

[cron.archive_cleanup]
RUN_AT_START = true
SCHEDULE = @midnight
; Archives created more than OLDER_THAN ago are subject to deletion
OLDER_THAN = 24h

; ; Update mirrors
[cron.update_mirrors]
SCHEDULE = @every 3h


; Repository health check
[cron.repo_health_check]
SCHEDULE = @midnight
TIMEOUT = 60s
; Arguments for command 'git fsck', e.g. "--unreachable --tags"
; see more on http://git-scm.com/docs/git-fsck
ARGS =

; Check repository statistics
[cron.check_repo_stats]
RUN_AT_START = true
SCHEDULE = @midnight

[api]
; Max number of items will response in a page
MAX_RESPONSE_ITEMS = 100

[other]
SHOW_FOOTER_BRANDING = false
; Show version information about Gitea and Go in the footer
SHOW_FOOTER_VERSION = true
; Show time of template execution in the footer
SHOW_FOOTER_TEMPLATE_LOAD_TIME = false

[openid]
ENABLE_OPENID_SIGNIN = true
ENABLE_OPENID_SIGNUP = false

[metrics]
; Enables metrics endpoint. True or false; default is false.
ENABLED = true

[oauth2]
ENABLED = false
; this is same as JWT secret above
JWT_SECRET = "${oauth2-jwt-secret}"

[federation]
ENABLED=false
;; Enable/Disable user statistics for nodeinfo if federation is enabled
;SHARE_USER_STATISTICS = true
;;
;; Maximum federation request and response size (MB)
;MAX_SIZE = 4
;;
;; WARNING: Changing the settings below can break federation.
;;
;; HTTP signature algorithms
;ALGORITHMS = rsa-sha256, rsa-sha512, ed25519
;;
;; HTTP signature digest algorithm
;DIGEST_ALGORITHM = SHA-256
;;
;; GET headers for federation requests
;GET_HEADERS = (request-target), Date
;;
;; POST headers for federation requests
;POST_HEADERS = (request-target), Date, Digest


[packages]
;; Enable/Disable package registry capabilities
ENABLED = true
