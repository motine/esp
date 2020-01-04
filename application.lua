dofile("lib/router.lua")
dofile("lib/server.lua")
dofile("lib/template.lua")

PINS = {
  PIN1 = 1,
  PIN2 = 2
}

function state_str(pin)
  if gpio.read(pin) == 0 then
    return "ON"
  else
    return "OFF"
  end
end

function handleIndex(params)
  local template = Template:new(nil, "index.html", "layout.html")
  local vars = {}

  for pinName, pinNo in pairs(PINS) do -- retrieve status of the pins
    vars[pinName .. "_state"] = state_str(pinNo)
  end
  
  return "200 OK", nil, template:render(vars)
end

function handleSwitch(params, pin, state)
  gpio.write(pin, state)
  return "302 Found", "Location: /", ""
end

function initGpio()
  for _, pin in pairs(PINS) do
    gpio.mode(pin, gpio.OUTPUT)
    gpio.write(pin, gpio.HIGH)
  end
end

initGpio()

mainRouter = Router:new()
mainRouter:addRoute("/", handleIndex)

for pinName, pinNo in pairs(PINS) do -- retrieve status of the pins
  print(pinName)
  mainRouter:addRoute("/" .. pinName .. "/on",  function(params) return handleSwitch(params, pinNo, gpio.LOW) end)
  mainRouter:addRoute("/" .. pinName .. "/off", function(params) return handleSwitch(params, pinNo, gpio.HIGH) end)
end


server = Server:new(nil, mainRouter)
server:start()
