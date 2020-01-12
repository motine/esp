# MoHA

- A device is a wifi node (typically an ESP).
- A component is either an actor or a sensor (e.g. a switch or an LED)

115200

## Actor implementation

ESP registers via mdns
Ruby server is client

Paths:

```json
# path: /moha/v1/
{
  "device": {
    "platform": "ESP8266",
    "comment": "built into the red box"
  },
  "components":
    [
      {
        "uuid": "b82ef140-c589-49bb-81fd-7c160be2ad16",
        "comment": "hard wired to the relay output 3",
        "type": "switch",
        "capabilities": ["http", "on/off"], // "brightness", "timer", "sleep-mode"
        "actions" : {
          "status":  { "http-path": "/moha/v1/switch1/status" },
          "on":  { "http-path": "/moha/v1/switch1/on" },
          "off": { "http-path": "/moha/v1/switch1/off" }
        }
      }
    ]
}
# path: /status
{
  "status": "on"
}
# path: /on | /off
{
  "status": "on"
}
```

## Server

server responsibilities:
- browser talks to the component directly (via `fetch`)
- discover devices & their actors
- map components to names
- deliver html


discover: mdns
Gem net-mdns

Install puma
Grape
Use rackup
Later with active record

Start with turbo links (later react?)

test: drive little light for projector with ws2812
