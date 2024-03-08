#!/bin/bash

#
# Configure random MAC addresses for NetworkManager
#

RANDOM_MAC_CONFIG_FILE=="/etc/NetworkManager/conf.d/99-random-mac.conf"

# Create the configuration file or overwrite if it already exists
cat <<EOF > "$RANDOM_MAC_CONFIG_FILE"
[device]
wifi.scan-rand-mac-address=yes

[connection]
wifi.cloned-mac-address=random
ethernet.cloned-mac-address=random
EOF

# Set appropriate permissions to the file
chmod 644 "$RANDOM_MAC_CONFIG_FILE"

# Reload NetworkManager configuration
sudo nmcli general reload conf

#
# Remove static hostname to prevent hostname broadcast
#

sudo hostnamectl "localhost"

#
# Disable sendind hostname to DHCP server
# This configuration will leak your hostname on first connection.
# Setting a generic or random hostname is strongly recommended if possible.
#
# This configuration is virtually useless without
# also randomizing MAC addreses by default
#

NO_SEND_HOSTNAME="/etc/NetworkManager/dispatcher.d/no-wait.d/01-no-send-hostname.sh"

cat <<EOF > "$NO_SEND_HOSTNAME"
#! /bin/bash

if [ "$(nmcli -g 802-11-wireless.cloned-mac-address c show "$CONNECTION_UUID")" = 'permanent' ] \
  || ["$(nmcli -g 802-3-ethernet.cloned-mac-address c show "$CONNECTION_UUID")" = 'permanent' ]
then
  nmcli connection modify "$CONNECTION_UUID" \
    ipv4.dhcp-send-hostname true \
    ipv6.dhcp-send-hostname true
else
  nmcli connection modify "$CONNECTION_UUID" \
    ipv4.dhcp-send-hostname false \
    ipv6.dhcp-send-hostname false
fi
EOF

# Set ownership and permissions
sudo chown root:root "$NO_SEND_HOSTNAME"

# Set permissions to 744 (rwxr--r--)
sudo chmod 744 "$NO_SEND_HOSTNAME"

# Create the symbolic link
sudo ln -s "$NO_SEND_HOSTNAME" ./

