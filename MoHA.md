# MoHA

- A device is a wifi node (typically an ESP).
- A device contains many skills
- A skill can be an actor or a sensor (e.g. a switch or an LED)

115200

## Actor implementation

- ESP registers via mdns
- Send all with `Access-Control-Allow-Origin: *`
- Browser is the client

Paths:

each action can be triggered with a get (to keep things simple for now)
each device lists its actions via html (`/`) and via json (`moha/v1/`).

```json
# path: /
<html>
switch 1: <a href="/moha/v1/switch1/on">on</a> | <a href="/moha/v1/switch1/on">off</a>
switch 2: <a href="/moha/v1/switch2/on">on</a> | <a href="/moha/v1/switch2/on">off</a>
</html>

# path: /moha/v1/
{
  "device": {
    "uuid": "d54e8c2d-c84e-456b-8e5b-87455d43195f",
    "platform": "ESP8266",
    "comment": "built into the red box"
  },
  "skills": [
    {
      "uuid": "b82ef140-c589-49bb-81fd-7c160be2ad16",
      "comment": "hard wired to the relay output 3",
      "type": "actor-switch",
      "capabilities": ["http", "on/off"], // "brightness", "timer", "sleep-mode"
      "actions" : {
        "status":  { "http-path": "/moha/v1/switch1/status" },
        "on":  { "http-path": "/moha/v1/switch1/on" },
        "off": { "http-path": "/moha/v1/switch1/off" }
      }
    }
  ]
}
# path: /moha/v1/switch1/status
{
  "status": "on"
}
# path: /moha/v1/switch1/on | /off
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
