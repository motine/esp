# MoHA - Motine Home Automation

Hardware: ESP8266

Access via: http://moha-lamp1.fritz.box/

```bash
# setup
cp credentials.lua.example credentials.lua
vim credentials

nodemcu-tool upload -k *.lua lib/*.lua templates/*
nodemcu-tool run init.lua
nodemcu-tool reset && sleep 0.1
```


## TODO

url schema:

```txt
/lamp1/on
/lamp1/off
/lamp1/dim?value=50
/lamp1    (Status)
```