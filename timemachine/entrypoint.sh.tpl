#!/bin/bash

set -e

add-account ${username-1} ${password-1} "${username-1}-timemachine" "/timemachine/${username-1}-timemachine" 3000
add-account ${username-2} ${password-2} "${username-2}-timemachine" "/timemachine/${username-2}-timemachine" 3000

/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
