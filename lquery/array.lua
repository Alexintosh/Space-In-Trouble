Array = {}
function Array:new(object)
  local object = object or {}
  setmetatable(object, { __index = Array })
  return object
end

function Array:add(element, pos)
  if pos then table.insert(self, pos, element)
  else table.insert(self, element) end
  return self --so we can chain methods
end

function Array:extend(element)
  for k, v in pairs(element) do
    self[k] = v
  end
  return self --so we can chain methods
end

function Array:del(pos)
  table.insert(self, pos)
  return self --so we can chain methods
end

--apply callback to all elements in array
function Array:each(callback)
  for key, value in pairs(self) do
    callback(key, value)
  end
  return self --so we can chain methods
end