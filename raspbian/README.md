# Update Firmware
`rpi-update"

# SSH
`ssh` server is installed by default.
- user: pi
- password: raspberry

# Internal DNS
Raspbian is setting resolv.conf to google's DNS servers ignoring DHCP.

To force your internal DNS servers execute:
```bash
echo "prepend domain-name-servers 10.0.0.1, 10.0.0.2;" >> /etc/dhcp/dhclient.conf`
```
Please replace `10.0.0.1` and `10.0.0.2` with your own servers.

Now you will need to restart networking to pick up changes:
```bash
/etc/init.d/networking restart
```
