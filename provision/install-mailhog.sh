#!/usr/bin/env bash
PATH_DOWNLOAD="https://github.com/mailhog/MailHog/releases/download/v0.1.8/MailHog_linux_386"
PATH_MAILHOG="/usr/local/bin/mailhog"

# Download binary from github
if [ ! -e /usr/local/bin/mailhog ]; then
    echo ">>> Installing Mailhog"

    wget -qO $PATH_MAILHOG $PATH_DOWNLOAD

    # Make it executable
    chmod +x $PATH_MAILHOG
else
    echo ">>> Mailhog installed"
fi

# Make it start on reboot
sudo tee /etc/init/mailhog.conf <<EOL
description "Mailhog"
start on runlevel [2345]
stop on runlevel [!2345]
respawn
pre-start script
    mailhog 1>/dev/null 2>&1
end script
EOL