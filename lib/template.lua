-- If a layout is given, it shall contain `{{ _page }}` placeholder for the actual template result to be inserted
-- Currently only simple variable substitution is supported. 
TEMPLATE_PATH = "templates"

Template = { source = nil, layout_source = nil }

function Template:new(o, filename, layout_filename)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.source = self:read_template(filename)
  if layout_filename then
    self.layout_source = self:read_template(layout_filename)
  end
  return o
end

-- reads the template from the file and returns the string
function Template:read_template(filename)
  local full_path = TEMPLATE_PATH .. "/" .. filename
  if not file.exists(full_path) then
    print("Template does not exist: " .. full_path)
    return "TEMPLATE DOES NOT EXIST!"
  end

  local fd = file.open(full_path, "r")
  local template = ""
  while true do
    local chunk = fd:read()
    if chunk == nil then break end
    template = template .. chunk
  end
  fd:close()
  return template
end

-- renders the given source template with the given vars
function Template:render_template(source, vars)
  local subsitutionFun = function(var)
    local var_value = vars[var]
    if var_value == nil then
      return "[MISSING VAR '" .. var .. "']"
    else
      return var_value
    end
  end
  return source:gsub("{{%s*([%w_]+)%s*}}", subsitutionFun)
end

-- renders the template and the layout (if present)
function Template:render(vars)
  local page = self:render_template(self.source, vars)

  if self.layout_source == nil then
    return page
  else
    vars["_page"] = page
    return self:render_template(self.layout_source, vars)
  end
end
