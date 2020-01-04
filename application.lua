dofile("lib/router.lua")
dofile("lib/server.lua")
dofile("lib/template.lua")

function handleIndex(params)
  local template = Template:new(nil, "index.html", "layout.html")
  local vars = {}
  vars["some_var"] = "SOME VAR"
  
  return "200 OK", nil, template:render(vars)
end

function handleOn(params)
  gpio.mode(0, gpio.OUTPUT)
  gpio.write(0, gpio.LOW)
  return "302 Found", "Location: /", ""
end

function handleOff(params)
  gpio.mode(0, gpio.OUTPUT)
  gpio.write(0, gpio.HIGH)
  return "302 Found", "Location: /", ""
end

mainRouter = Router:new()
mainRouter:addRoute("/", handleIndex)
mainRouter:addRoute("/on", handleOn)
mainRouter:addRoute("/off", handleOff)

server = Server:new(nil, mainRouter)
server:start()
