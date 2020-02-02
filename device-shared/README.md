# ESP Device API

please see `relais-webserver` and the top level `README.md` for more info.

```bash
# setup
cp credentials.lua.example credentials.lua
vim credentials # change your credentials

# useful commands
nodemcu-tool upload -k *.lua lib/*.lua
nodemcu-tool terminal # now reset the device and see what comes up
```
