dofile("lib/router.lua")
dofile("lib/server.lua")

PIN = 1
DEFAULT_HEADER = "Access-Control-Allow-Origin: *"
JSON_HEADER = DEFAULT_HEADER .. "\nContent-Type: application/json"

function handleIndex(params)
  return "200 OK", DEFAULT_HEADER, [[<html><body><a href="/moha/v1/">discover</a><br/>switch: <a href="/moha/v1/switch1/status">status</a> | <a href="/moha/v1/switch1/on">on</a> | <a href="/moha/v1/switch1/off">off</a></body></html>]]
end

function handleDiscover(params, pin)
  return "200 OK", JSON_HEADER, [[
{
  "device": {
    "uuid": "44de4240-12a7-46a9-a0e1-724304d2d1f3",
    "platform": "ESP8266",
    "comment": "cinema shelve"
  },
  "skills": [
    {
      "uuid": "35f2ca65-fbc6-402a-bebe-69012dfe8315",
      "comment": "220v relais, wired to the lamp",
      "type": "actor-switch",
      "capabilities": ["on/off"],
      "actions" : {
        "status":  { "http-path": "/moha/v1/switch1/status" },
        "on":  { "http-path": "/moha/v1/switch1/on" },
        "off": { "http-path": "/moha/v1/switch1/off" }
      }
    }
  ]
}
  ]]
end

function handleStatus(params)
  if gpio.read(PIN) == gpio.LOW then
    return "200 OK", JSON_HEADER, '{"status": "on"}'
  else
    return "200 OK", JSON_HEADER, '{"status": "off"}'
  end

end
function handleOn(params)
  gpio.write(PIN, gpio.LOW)
  return "200 OK", JSON_HEADER, '{"status": "on"}'
end

function handleOff(params)
  gpio.write(PIN, gpio.HIGH)
  return "200 OK", JSON_HEADER, '{"status": "off"}'
end

function initGpio()
  gpio.mode(PIN, gpio.OUTPUT)
  gpio.write(PIN, gpio.HIGH)
end

initGpio()

mainRouter = Router:new()
mainRouter:addRoute("/", handleIndex)
mainRouter:addRoute("/moha/v1/", handleDiscover)
mainRouter:addRoute("/moha/v1/switch1/status", handleStatus)
mainRouter:addRoute("/moha/v1/switch1/on", handleOn)
mainRouter:addRoute("/moha/v1/switch1/off", handleOff)

server = Server:new(nil, mainRouter)
server:start()
