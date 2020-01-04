# ESP8266 Actor

```bash
# setup
cp credentials.lua.example credentials.lua
vim credentials

nodemcu-tool upload -k *.lua lib/*.lua
nodemcu-tool run init.lua
nodemcu-tool reset && sleep 0.1
```