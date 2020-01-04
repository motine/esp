dofile("lib/router.lua")
dofile("lib/server.lua")
dofile("lib/template.lua")

function handleIndex(params)
  local template = Template:new(nil, "index.html", "layout.html")
  local vars = {}
  vars["some_var"] = "SOME VAR"
  
  return template:render(vars)
end

mainRouter = Router:new()
mainRouter:addRoute("/", handleIndex)

server = Server:new(nil, mainRouter)
server:start()
