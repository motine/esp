-- Currently only simple variable substitution is supported. 
TEMPLATE_PATH = "templates"

Template = { source = nil }

function Template:new(o, filename)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self:read(filename)
  return o
end

-- reads the template from the file and returns the string
function Template:read(filename)
  local full_path = TEMPLATE_PATH .. "/" .. filename
  if not file.exists(full_path) then
    print("Template does not exist: " .. full_path)
    return "TEMPLATE DOES NOT EXIST!"
  end

  local fd = file.open(full_path, "r")
  self.source = ""
  while true do
    local chunk = fd:read()
    if chunk == nil then break end
    self.source = self.source .. chunk
  end
  fd:close()
end

-- renders the given source template with the given vars
function Template:render(vars)
  local subsitutionFun = function(var)
    local var_value = vars[var]
    if var_value == nil then
      return "[MISSING VAR '" .. var .. "']"
    else
      return var_value
    end
  end
  return self.source:gsub("{{%s*([%w_]+)%s*}}", subsitutionFun)
end
