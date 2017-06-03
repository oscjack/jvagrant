#!/usr/bin/env bash

##############Setup MailCatcher on Ubuntu 16.04################################

# build-essential needed for "make" command
sudo apt-get install -y build-essential software-properties-common vim curl wget tmux

# Install Mailcatcher Dependencies (sqlite, ruby)
sudo apt-get install -y libsqlite3-dev ruby-dev

# Install Mailcatcher as a Ruby gem
sudo gem install mailcatcher

##############Setup MailCatcher on Ubuntu 16.04################################


# Make it start on reboot
sudo tee /etc/systemd/system/mailcatcher.service <<EOL
[Unit]
Description=MailCatcher Service

[Service]
ExecStart=mailcatcher --ip 0.0.0.0
KillMode=process
Restart=on-failure
RestartPreventExitStatus=255
Type=notify

[Install]
WantedBy=multi-user.target
Alias=mailcatcher.service
EOL

sudo systemctl enable mailcatcher.service
