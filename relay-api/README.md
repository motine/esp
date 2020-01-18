# ESP Relay API

please see `relais-webserver` and the top level `README.md` for more info.

```bash
# setup
cp credentials.lua.example credentials.lua
vim credentials # change your credentials

# useful commands
nodemcu-tool terminal # now reset the device and see what comes up
nodemcu-tool upload -k *.lua lib/*.lua
# now reset the ESP and it should show up on your network
nodemcu-tool reset && sleep 0.1
```
