Server = { router = {} }

function Server:new(o, router)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.router = router
  return o
end

-- returns method, path, params
function Server:parseRequest(request)
  local method, uri = request:match("^(%a+) (/.*) HTTP") -- tested example: GET /favicon.ico/a?asd=1&c=b%20c HTTP/1.1
  local path, queryString = uri:match("^(/.*)?(.+)$")
  if path == nil then -- we do not have parameter, so we can just return the full uri
    return method, uri, {}
  end

  local params = {}
  for pairString in queryString:gmatch("([^&]+)") do
    local key, value = pairString:match("^(.+)=(.+)$")
    params[key] = value
  end
  return method, path, params
end

function Server:handleConnection(conn, payload)
  -- dispatch request via router
  local method, path, params = self:parseRequest(payload)
  local response = self.router:handle(method, path, params)
  local status = "200 OK"
  if response == nil then
    code = "404 Not Found"
    response = "<h1>404 - Not found</h1>"
  end
  conn:send("HTTP/1.1 " .. status .. "\nContent-Type: text/html\nConnection: Closed\n\n" .. response)
end

function Server:start()
  print("Starting server...")
  srv = net.createServer(net.TCP)
  srv:listen(80, function(conn)
    conn:on("receive", function(conn, payload)
      handleFun = function() self:handleConnection(conn, payload) end
      errFun = function (err)   conn:send("HTTP/1.1 500\n\n" .. "<h1>500 - Server Error</h1><code>" .. err .. "</code>") end
      xpcall(handleFun, errFun)
    end)
    conn:on("sent", function(conn) conn:close() end)
  end)
end

-- request = [[
-- GET /favicon.ico/a?asd=1&c=b%20c HTTP/1.1
-- Host: 192.168.178.114
-- User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:70.0) Gecko/20100101 Firefox/70.0
-- Accept: image/webp,*/*
-- Accept-Language: en-US,en;q=0.5
-- Accept-Encoding: gzip, deflate
-- Connection: keep-alive
-- Cache-Control: max-age=0 ]]

-- method, path, params = parseRequest(request)
-- print(method)
-- print(path)
-- for k,v in pairs(params) do
--   print(k .. "  =  " .. v)
-- end
