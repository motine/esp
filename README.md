# MoHA - Motine Home Automation

This project is not for the public. It is not fully documented yet.

## Getting started

Assuming you have an ESP8266 ready to go and have installed `nodemcu-tool`. If not see below.

<!-- Access via: http://moha-lamp1.fritz.box/ -->

```bash
# setup
cp credentials.lua.example credentials.lua
vim credentials # change your credentials

# useful commands
nodemcu-tool upload -k *.lua lib/*.lua templates/*
# now reset the ESP and it should show up on your network
nodemcu-tool reset && sleep 0.1
```

## Initial setup

derived from [this article](https://medium.com/@bass.pj/nodemcu-esp8266-getting-started-with-arduino-on-macos-1cdc61565496).
Check this the [NodeMCU Getting Started](https://nodemcu.readthedocs.io/en/master/getting-started/) Guide for more info.

**Install Device**

1. Install the driver for Mac from [here](https://www.silabs.com/products/development-tools/software/usb-to-uart-bridge-vcp-drivers)
1. Plug in the device, then `ls /dev` should include something like: `tty.usbserial-0001` and `tty.SLAB_USBtoUART`

**Flash NodeMCU**

1. Goto [nodemcu-build.com](https://nodemcu-build.com/) and build an image and save it to downloads folder (select LFS size `64KB`)[^img]
1. Install [esptool](https://github.com/espressif/esptool) via `pip3 install esptool` (install pip via `brew install python`)[^flasher]
1. Flash: `esptool.py erase_flash` then `esptool.py --port /dev/cu.SLAB_USBtoUART --baud 115200 write_flash -fm qio 0x00000 nodemcu-master-15-modules-2020-01-03-19-24-21-integer.bin`

<!-- file, gpio, http, i2c, net, node, ow, pcm, rtctime, spi, tmr, uart, websocket, wifi, wifi_monitor -->

[^flasher]: Alternatively to using esptool, you can download the nodemcu flasher from [nodemcu-pyflasher](https://github.com/marcelstoer/nodemcu-pyflasher/releases)
[^img]: Alternatively to building your own image you can download the latest release from [github/nodemcu-firmware](https://github.com/nodemcu/nodemcu-firmware/releases) and then build it using docker like [here](https://hub.docker.com/r/vowstar/esp8266/).

**Upload code**

1. Install [NodeMCU-Tool](https://github.com/andidittrich/NodeMCU-Tool): `npm install nodemcu-tool -g`
1. Download test script `wget https://raw.githubusercontent.com/AndiDittrich/NodeMCU-Tool/master/helloworld.lua`
1. Upload test code `nodemcu-tool --port=/dev/cu.SLAB_USBtoUART upload helloworld.lua`
1. Run test code `nodemcu-tool --port=/dev/cu.SLAB_USBtoUART run helloworld.lua`
