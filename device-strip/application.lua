dofile("lib/router.lua")
dofile("lib/server.lua")

PIN = 4
LED_COUNT = 200
DEFAULT_HEADER = "Access-Control-Allow-Origin: *"
JSON_HEADER = DEFAULT_HEADER .. "\nContent-Type: application/json"

buffer = 0
current_color = { r = 0, g = 0, b = 0 }

function handleIndex(params)
  return "200 OK", DEFAULT_HEADER, [[<html><body><a href="/moha/v1/">discover</a><br/>switch: <a href="/moha/v1/strip1/status">status</a> | <a href="/moha/v1/strip1/on">on</a> | <a href="/moha/v1/strip1/off">off</a> | <a href="/moha/v1/strip1/rgb?r=255&g=0&b=0">red</a></body></html>]]
end

function handleDiscover(params, pin)
  return "200 OK", JSON_HEADER, [[
{
  "device": {
    "uuid": "e7274575-4c5e-41bc-936c-4bc33b572677",
    "platform": "ESP32",
    "comment": "test device"
  },
  "skills": [
    {
      "uuid": "fe11e88b-1f28-479b-899d-0454c2897d17",
      "comment": "led strip WS2812b",
      "type": "actor-strip",
      "capabilities": ["on/off", "rgb"],
      "actions" : {
        "status":  { "http-path": "/moha/v1/strip1/status" },
        "on":  { "http-path": "/moha/v1/strip1/on" },
        "off": { "http-path": "/moha/v1/strip1/off" },
        "rgb": { "http-path": "/moha/v1/strip1/rgb" }
      }
    }
  ]
}
  ]]
end

function getStatusJson()
  if (current_color.r == 0) and (current_color.g == 0) and (current_color.b == 0) then
    return '{"status": "off"}'
  else
    return '{"status": "on", "r": ' .. current_color.r .. ', "g": ' .. current_color.g .. ', "b": ' .. current_color.b .. '}'
  end
end

function handleStatus(params)
  return "200 OK", JSON_HEADER, getStatusJson()
end

function handleOn(params)
  setColor(255, 255, 255)
  return "200 OK", JSON_HEADER, getStatusJson()
end

function handleOff(params)
  setColor(0, 0, 0)
  return "200 OK", JSON_HEADER, getStatusJson()
end

function handleRGB(params)
  setColor(params.r, params.g, params.b)
  return "200 OK", JSON_HEADER, getStatusJson()
end

function setColor(r, g, b)
  current_color = { r = r, g = g, b = b }
  buffer:fill(g, r, b)
  for i = 0, 3, 1 do -- somehow we need to do this multiple times, I suspect it is because of the missing level-conversion between 3.3V and 5V
    ws2812.write({pin = PIN, data = buffer})
  end
end

function initStrip()
  buffer = ws2812.newBuffer(LED_COUNT, 3);
  setColor(current_color.r, current_color.g, current_color.b)
  -- tmr.create():alarm(10, 1, function()
  --   ws2812.write({pin = PIN, data = buffer})
  -- end)
end

initStrip()

mainRouter = Router:new()
mainRouter:addRoute("/", handleIndex)
mainRouter:addRoute("/moha/v1/", handleDiscover)
mainRouter:addRoute("/moha/v1/strip1/status", handleStatus)
mainRouter:addRoute("/moha/v1/strip1/on", handleOn)
mainRouter:addRoute("/moha/v1/strip1/off", handleOff)
mainRouter:addRoute("/moha/v1/strip1/rgb", handleRGB)

server = Server:new(nil, mainRouter)
server:start()
