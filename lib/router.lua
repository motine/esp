Router = { routes = {} }

function Router:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Router:addRoute(path, handler)
  self.routes[path] = { handler=handler }
end

function Router:handle(method, path, params)
  -- find route info
  local routeInfo = self.routes[path]
  if routeInfo == nil then
    print("could not find handler for " .. path)
    return
  end

  -- call handler
  return routeInfo.handler(params)
end
