dofile("lib/router.lua")
dofile("lib/server.lua")

function handleIndex(params)
  -- print('param x:' .. params["myparam"])
  return "<h1>Hello!</h1>"
end

mainRouter = Router:new()
mainRouter:addRoute("/", handleIndex)

server = Server:new(nil, mainRouter)
server:start()
