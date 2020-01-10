# ESP Relay Web Server

Drive a relay through a website hosted on the esp.
Implements my own little router and template renderer.

## Getting started

Assuming you have an ESP8266 ready to go and have installed `nodemcu-tool`. If not see below.

<!-- Access via: http://moha-lamp1.fritz.box/ -->

```bash
# setup
cp credentials.lua.example credentials.lua
vim credentials # change your credentials

# useful commands
nodemcu-tool terminal # now reset the device and see what comes up
nodemcu-tool upload -k *.lua lib/*.lua templates/*
# now reset the ESP and it should show up on your network
nodemcu-tool reset && sleep 0.1
```
