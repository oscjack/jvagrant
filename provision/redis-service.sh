[Unit]
Description=Redis Datastore Server
After=network.target

[Service]
Type=forking
PIDFile=/var/run/redis/redis.pid
ExecStartPre=/bin/mkdir -p /var/run/redis
ExecStartPre=/bin/chown redis:redis /var/run/redis

ExecStart=/sbin/start-stop-daemon --start --chuid redis:redis --pidfile /var/run/redis/redis.pid --umask 007 --exec /usr/bin/redis-server -- /etc/redis/redis.conf
ExecReload=/bin/kill -USR2 $MAINPID

[Install]
WantedBy=multi-user.target