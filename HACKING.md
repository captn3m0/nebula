# Hacking on the thing

Generate certs as per:

https://gist.github.com/captn3m0/2c2e723b2dcd5cdaad733aad12be59a2

Copy ca.pem, server-cert.pem, server-key.pem to /etc/docker/certs.

Make sure server-key.pem is 0400 in permissions.

Run `systemctl edit docker`

````
/etc/systemd/system/docker.service.d/override.conf
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd --tlsverify --tlscacert=/etc/docker/certs/ca.pem --tlscert=/etc/docker/certs/server-cert.pem --tlskey=/etc/docker/certs/server-key.pem -H=0.0.0.0:2376 -H unix:///var/run/docker.sock
````
