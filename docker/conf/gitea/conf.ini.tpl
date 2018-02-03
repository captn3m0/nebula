; This file lists the default values used by Gitea
; Copy required sections to your own app.ini (default is custom/conf/app.ini)
; and modify as needed.

; App name that shows on every page title
APP_NAME = Nemo's code
RUN_MODE = prod
RUN_USER = git

[repository]
ROOT = /data/git/repositories

[repository.upload]
TEMP_PATH = /data/gitea/uploads

[ui]
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
CUSTOM_URL_SCHEMES = git,magnet,steam
; List of file extensions that should be rendered/edited as Markdown
; Separate extensions with a comma. To render files w/o extension as markdown, just put a comma
FILE_EXTENSIONS = .md,.markdown,.mdown,.mkd

; Define allowed algorithms and their minimum key length (use -1 to disable a type)
[ssh.minimum_key_sizes]
ED25519 = 256
ECDSA = 256
RSA = 2048
DSA = 1024


[server]
APP_DATA_PATH    = /data/gitea
SSH_DOMAIN       = git.captnemo.in
HTTP_PORT        = 3000
ROOT_URL         = https://git.captnemo.in/
DISABLE_SSH      = false
SSH_PORT         = 22
DOMAIN           = git.captnemo.in
LFS_START_SERVER = true
LFS_CONTENT_PATH = /data/gitea/lfs
LFS_JWT_SECRET   = nsLco71Wn4iu_UzyDir0jzkCdJDya1L9N0KZfgew13E
OFFLINE_MODE     = true

[database]

; TODO
; ; Either "mysql", "postgres", "mssql" or "sqlite3", it's your choice
; DB_TYPE = mysql
; HOST = 127.0.0.1:3306
; NAME = gitea
; USER = root
; PASSWD =
; ; For "postgres" only, either "disable", "require" or "verify-full"
; SSL_MODE = disable
; ; For "sqlite3" and "tidb", use absolute path when you start as service
; PATH = data/gitea.db
; ; For "sqlite3" only. Query timeout
; SQLITE_TIMEOUT = 500
; ; For iterate buffer, default is 50
; ITERATE_BUFFER_SIZE = 50

PATH     = /data/gitea/gitea.db
DB_TYPE  = sqlite3
HOST     = localhost:3306
NAME     = gitea
USER     = root
PASSWD   =
SSL_MODE = disable

[session]
PROVIDER_CONFIG = /data/gitea/sessions
PROVIDER        = file

[picture]
AVATAR_UPLOAD_PATH      = /data/gitea/avatars
DISABLE_GRAVATAR        = true
ENABLE_FEDERATED_AVATAR = false

[indexer]
ISSUE_INDEXER_PATH = indexers/issues.bleve
; repo indexer by default disabled, since it uses a lot of disk space
REPO_INDEXER_ENABLED = false
REPO_INDEXER_PATH = indexers/repos.bleve
UPDATE_BUFFER_LEN = 20
MAX_FILE_SIZE = 1048576

[admin]
; Disable regular (non-admin) users to create organizations
DISABLE_REGULAR_ORG_CREATION = false

[security]
; Whether the installer is disabled
INSTALL_LOCK = true
; Auto-login remember days
LOGIN_REMEMBER_DAYS = 30
; COOKIE_USERNAME = gitea_awesome
; COOKIE_REMEMBER_NAME = gitea_incredible
; Reverse proxy authentication header name of user name
; REVERSE_PROXY_AUTHENTICATION_USER = X-WEBAUTH-USER
; Sets the minimum password length for new Users
MIN_PASSWORD_LENGTH = 10
; True when users are allowed to import local server paths
IMPORT_LOCAL_PATHS = false
; Prevent all users (including admin) from creating custom git hooks
DISABLE_GIT_HOOKS = true

SECRET_KEY     = ${secret_key}
INTERNAL_TOKEN = ${internal_token}

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
DISABLE_REGISTRATION              = false
; ; Enable captcha validation for registration
ENABLE_CAPTCHA                    = true
; ; User must sign in to view anything.
REQUIRE_SIGNIN_VIEW               = false
; ; Default value for KeepEmailPrivate
; ; New user will get the value of this setting copied into their profile
DEFAULT_KEEP_EMAIL_PRIVATE        = false
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

; [webhook]
; ; Hook task queue length, increase if webhook shooting starts hanging
; QUEUE_LENGTH = 1000
; ; Deliver timeout in seconds
; DELIVER_TIMEOUT = 5
; ; Allow insecure certification
; SKIP_TLS_VERIFY = false
; ; Number of history information in each page
; PAGING_NUM = 10

[mailer]
ENABLED = true
; ; Buffer length of channel, keep it as it is if you don't know what it is.
; SEND_BUFFER_LEN = 100
; ; Name displayed in mail title
; SUBJECT = %(APP_NAME)s
; ; Mail server
; ; Gmail: smtp.gmail.com:587
; ; QQ: smtp.qq.com:465
; ; Note, if the port ends with "465", SMTPS will be used. Using STARTTLS on port 587 is recommended per RFC 6409. If the server supports STARTTLS it will always be used.
HOST = smtp.migadu.com:587
; ; Disable HELO operation when hostname are different.
; DISABLE_HELO =
; ; Custom hostname for HELO operation, default is from system.
; HELO_HOSTNAME =
; ; Do not verify the certificate of the server. Only use this for self-signed certificates
; SKIP_VERIFY =
; ; Use client certificate
; USE_CERTIFICATE = false
; CERT_FILE = custom/mailer/cert.pem
; KEY_FILE = custom/mailer/key.pem
; ; Mail from address, RFC 5322. This can be just an email address, or the `"Name" <email@example.com>` format
FROM = git@captnemo.in
; ; Mailer user name and password
USER = git@captnemo.in
PASSWD = ${smtp_password}
; ; Send mails as plain text
SEND_AS_PLAIN_TEXT = true
; ; Enable sendmail (override SMTP)
; USE_SENDMAIL = false
; ; Specify an alternative sendmail binary
; SENDMAIL_PATH = sendmail
; ; Specify any extra sendmail arguments
; SENDMAIL_ARGS =

; [cache]
; ; Either "memory", "redis", or "memcache", default is "memory"
; ADAPTER = memory
; ; For "memory" only, GC interval in seconds, default is 60
; INTERVAL = 60
; ; For "redis" and "memcache", connection host address
; ; redis: network=tcp,addr=:6379,password=macaron,db=0,pool_size=100,idle_timeout=180
; ; memcache: `127.0.0.1:11211`
; HOST =
; ; Time to keep items in cache if not used, default is 16 hours.
; ; Setting it to 0 disables caching
; ITEM_TTL = 16h

[session]
; ; Either "memory", "file", or "redis", default is "memory"
; PROVIDER = memory
; ; Provider config options
; ; memory: not have any config yet
; ; file: session file path, e.g. `data/sessions`
; ; redis: network=tcp,addr=:6379,password=macaron,db=0,pool_size=100,idle_timeout=180
; ; mysql: go-sql-driver/mysql dsn config string, e.g. `root:password@/session_table`
; PROVIDER_CONFIG = data/sessions
; ; Session cookie name
COOKIE_NAME = i_like_gitea
; ; If you use session in https only, default is false
COOKIE_SECURE = true
; ; Enable set cookie, default is true
ENABLE_SET_COOKIE = true
; ; Session GC time interval in seconds, default is 86400 (1 day)
; GC_INTERVAL_TIME = 86400
; ; Session life time in seconds, default is 86400 (1 day)
SESSION_LIFE_TIME = 2592000

; [picture]
; AVATAR_UPLOAD_PATH = data/avatars
; ; Chinese users can choose "duoshuo"
; ; or a custom avatar source, like: http://cn.gravatar.com/avatar/
; GRAVATAR_SOURCE = gravatar
; ; This value will be forced to be true in offline mode.
; DISABLE_GRAVATAR = false
; ; Federated avatar lookup uses DNS to discover avatar associated
; ; with emails, see https://www.libravatar.org
; ; This value will be forced to be false in offline mode or Gravatar is disabled.
; ENABLE_FEDERATED_AVATAR = false

; [attachment]
; ; Whether attachments are enabled. Defaults to `true`
; ENABLE = true
; ; Path for attachments. Defaults to `data/attachments`
; PATH = data/attachments
; ; One or more allowed types, e.g. image/jpeg|image/png
ALLOWED_TYPES = image/jpeg|image/png|application/zip|application/gzip|application/pdf|text/csv
; ; Max size of each file. Defaults to 32MB
; MAX_SIZE = 4
; ; Max number of files per upload. Defaults to 10
; MAX_FILES = 5

; [time]
; ; Specifies the format for fully outputted dates. Defaults to RFC1123
; ; Special supported values are ANSIC, UnixDate, RubyDate, RFC822, RFC822Z, RFC850, RFC1123, RFC1123Z, RFC3339, RFC3339Nano, Kitchen, Stamp, StampMilli, StampMicro and StampNano
; ; For more information about the format see http://golang.org/pkg/time/#pkg-constants
; FORMAT =

; [log]
; ROOT_PATH =
; ; Either "console", "file", "conn", "smtp" or "database", default is "console"
; ; Use comma to separate multiple modes, e.g. "console, file"
; MODE = console
; ; Buffer length of channel, keep it as it is if you don't know what it is.
; BUFFER_LEN = 10000
; ; Either "Trace", "Debug", "Info", "Warn", "Error", "Critical", default is "Trace"
LEVEL = Info

; ; For "console" mode only
; [log.console]
; LEVEL =

; ; For "file" mode only
; [log.file]
; LEVEL =
; ; This enables automated log rotate(switch of following options), default is true
; LOG_ROTATE = true
; ; Max line number of single file, default is 1000000
; MAX_LINES = 1000000
; ; Max size shift of single file, default is 28 means 1 << 28, 256MB
; MAX_SIZE_SHIFT = 28
; ; Segment log daily, default is true
; DAILY_ROTATE = true
; ; Expired days of log file(delete after max days), default is 7
; MAX_DAYS = 7

; ; For "conn" mode only
; [log.conn]
; LEVEL =
; ; Reconnect host for every single message, default is false
; RECONNECT_ON_MSG = false
; ; Try to reconnect when connection is lost, default is false
; RECONNECT = false
; ; Either "tcp", "unix" or "udp", default is "tcp"
; PROTOCOL = tcp
; ; Host address
; ADDR =

; ; For "smtp" mode only
; [log.smtp]
; LEVEL =
; ; Name displayed in mail title, default is "Diagnostic message from server"
; SUBJECT = Diagnostic message from server
; ; Mail server
; HOST =
; ; Mailer user name and password
; USER =
; PASSWD =
; ; Receivers, can be one or more, e.g. 1@example.com,2@example.com
; RECEIVERS =

; ; For "database" mode only
; [log.database]
; LEVEL =
; ; Either "mysql" or "postgres"
; DRIVER =
; ; Based on xorm, e.g.: root:root@localhost/gitea?charset=utf8
; CONN =

[cron]
; Enable running cron tasks periodically.
ENABLED = true
; ; Run cron tasks when Gitea starts.
RUN_AT_START = false

; ; Update mirrors
[cron.update_mirrors]
SCHEDULE = @every 3h

; ; Repository health check
; [cron.repo_health_check]
; SCHEDULE = @every 24h
; TIMEOUT = 60s
; ; Arguments for command 'git fsck', e.g. "--unreachable --tags"
; ; see more on http://git-scm.com/docs/git-fsck/1.7.5
; ARGS =

; ; Check repository statistics
; [cron.check_repo_stats]
; RUN_AT_START = true
; SCHEDULE = @every 24h

; ; Clean up old repository archives
; [cron.archive_cleanup]
; ; Whether to enable the job
; ENABLED = true
; ; Whether to always run at least once at start up time (if ENABLED)
; RUN_AT_START = true
; ; Time interval for job to run
; SCHEDULE = @every 24h
; ; Archives created more than OLDER_THAN ago are subject to deletion
; OLDER_THAN = 24h

; ; Synchronize external user data (only LDAP user synchronization is supported)
; [cron.sync_external_users]
; ; Synchronize external user data when starting server (default false)
; RUN_AT_START = false
; ; Interval as a duration between each synchronization (default every 24h)
; SCHEDULE = @every 24h
; ; Create new users, update existing user data and disable users that are not in external source anymore (default)
; ;   or only create new users if UPDATE_EXISTING is set to false
; UPDATE_EXISTING = true

; [git]
; ; Disables highlight of added and removed changes
; DISABLE_DIFF_HIGHLIGHT = false
; ; Max number of lines allowed of a single file in diff view
; MAX_GIT_DIFF_LINES = 1000
; ; Max number of characters of a line allowed in diff view
; MAX_GIT_DIFF_LINE_CHARACTERS = 5000
; ; Max number of files shown in diff view
; MAX_GIT_DIFF_FILES = 100
; ; Arguments for command 'git gc', e.g. "--aggressive --auto"
; ; see more on http://git-scm.com/docs/git-gc/1.7.5
; GC_ARGS =

; ; Operation timeout in seconds
[git.timeout]
MIGRATE = 600
MIRROR = 300
CLONE = 300
PULL = 300
GC = 60

; [mirror]
; ; Default interval as a duration between each check
; DEFAULT_INTERVAL = 8h
; ; Min interval as a duration must be > 1m
; MIN_INTERVAL = 10m

[api]
; Max number of items will response in a page
MAX_RESPONSE_ITEMS = 100

; [i18n]
; LANGS = en-US,zh-CN,zh-HK,zh-TW,de-DE,fr-FR,nl-NL,lv-LV,ru-RU,ja-JP,es-ES,pt-BR,pl-PL,bg-BG,it-IT,fi-FI,tr-TR,cs-CZ,sr-SP,sv-SE,ko-KR
; NAMES = English,简体中文,繁體中文（香港）,繁體中文（台灣）,Deutsch,français,Nederlands,latviešu,русский,日本語,español,português do Brasil,polski,български,italiano,suomi,Türkçe,čeština,српски,svenska,한국어

; ; Used for datetimepicker
; [i18n.datelang]
; en-US = en
; zh-CN = zh
; zh-HK = zh-TW
; zh-TW = zh-TW
; de-DE = de
; fr-FR = fr
; nl-NL = nl
; lv-LV = lv
; ru-RU = ru
; ja-JP = ja
; es-ES = es
; pt-BR = pt-BR
; pl-PL = pl
; bg-BG = bg
; it-IT = it
; fi-FI = fi
; tr-TR = tr
; cs-CZ = cs-CZ
; sr-SP = sr
; sv-SE = sv
; ko-KR = ko

; ; Extension mapping to highlight class
; ; e.g. .toml=ini
; [highlight.mapping]

[other]
SHOW_FOOTER_BRANDING = false
; Show version information about Gitea and Go in the footer
SHOW_FOOTER_VERSION = true
; Show time of template execution in the footer
SHOW_FOOTER_TEMPLATE_LOAD_TIME = false

; [markup.asciidoc]
; ENABLED = false
; ; List of file extensions that should be rendered by an external command
; FILE_EXTENSIONS = .adoc,.asciidoc
; ; External command to render all matching extensions
; RENDER_COMMAND = "asciidoc --out-file=- -"
; ; Input is not a standard input but a file
; IS_INPUT_FILE = false


[openid]
ENABLE_OPENID_SIGNIN = true
ENABLE_OPENID_SIGNUP = false
