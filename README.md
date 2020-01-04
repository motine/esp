# MoHa - Motine Home Automation

- ESP8266

Access via: http://moha-lamp1.fritz.box/

```bash
# setup
cp credentials.lua.example credentials.lua
vim credentials

nodemcu-tool upload -k *.lua lib/*.lua
nodemcu-tool run init.lua
nodemcu-tool reset && sleep 0.1
```