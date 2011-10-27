Entities = {}     --All entities in the game
Entity = {}       --Any object: box, circle, character etc
function Entity:new(obj)  -- constructor
  local object = Array:new({
    --position information
    x = 0,   --x coord
    y = 0,   --y coord
    z = 0,   --z-index (layers)
    --R = 0, --Radius (note, that r is color component, but R is radius)
    --color information
    --r = 255, --red
    --g = 255, --green
    --b = 255, --blue
    --a = 1,   --alpha
    --dimensions
    --w = 0,   --width
    --h = 0,   --height
    --events
    --click = nil,     --function (x, y, button)
    --mouseover = nil, --function (x, y)
    --mouseout = nil,  --function (x, y)
    --mousemove = nil, --function (x, y) --when mouse moves on entity
    --callbacks
    --draw = nil, --function that calls for drawing the object
    --test = function (x) print(x or 'error') end,
    --internal vars
    --_animQueue = {}, --animation queue
  }):extend(obj)
  setmetatable(object, { __index = Entity })  -- Inheritance
  table.insert(Entities,  object)
  object._key = #Entities
  return object
end


--circle
local circle_draw = function(s)
  G.setColor(s.r or 255, s.g or 255, s.b or 255, s.a or 255)
  G.circle("fill", s.x, s.y, s.R, 2*s.R)
end
function Entity:new_circle(radius)
  return Entity:new({R = radius or 10, draw=circle_draw})
end

--Sets x and y position of entity
function Entity:move(x, y)
  self.x = x
  self.y = y
  return self --so we can chain methods
end
--Sets radius of entity
function Entity:radius(R)
  self.R = R
  return self --so we can chain methods
end
--Sets width and height of entity
function Entity:size(w, h)
  self.R = R
  return self --so we can chain methods
end
--Sets color of entity
function Entity:color(r, g, b, a)
  self.r = r or 255
  self.g = g or 255
  self.b = b or 255
  self.a = a or 255
  return self --so we can chain methods
end

--Animates all values of entity to the given values in keys with the given speed
--examples:
--ent:animate({x=100,y=100}, {speed=0.3}) - move entity to 100, 100 for 300 msecs
--ent:animate({r=0,g=0,b=0,a=0}, {speed=0.3, easing='linear'}) - fade down with given easing function
--ent:animate({value=29, frame=53}, {speed=2}) - animate specific parameters of entity
function Entity:animate(keys, options)
  if keys then
    if not self._animQueue then self._animQueue = {} end
    if not options then options = {} end
    local queue = options.queue or "main" --you can manage with some queues
    if not self._animQueue[queue] then self._animQueue[queue] = {} end
    table.insert(self._animQueue[queue], {
      keys = keys,
      old = {},
      speed = (options.speed or 0.3),
      lasttime = nil, 
      easing = options.easing or 'swing',
      callback = options.callback
    })
  end
  return self --so we can chain methods
end

--deleay between animation queues
function Entity:delay(options)
  return self:animate({}, options)
end

--stop animation
--ent:stop() - stop all animations
--ent:stop('anim_group_1') - stop all animatios in queue 'anim_group_1'
function Entity:stop(queue)
  if queue then
    self._animQueue[queue] = {}
  else
    self._animQueue = {}
  end
  return self --so we can chain methods
end


--callbacks
function Entity:click(callback)
  self._control = true
  if callback then self._click = callback end
  return self --so we can chain methods
end
function Entity:mouseover(callback)
  self._control = true
  if callback then self._mouseover = callback end
  return self --so we can chain methods
end
function Entity:mouseout(callback)
  self._control = true
  if callback then self._mouseout = callback end
  return self --so we can chain methods
end



function Entity:draw(callback)
  if callback then self.draw = callback  else
  if self.draw then self.draw(self) end  end
  return self --so we can chain methods
end

--delete object
--how to remove object correctly and free memory:
--a = a:delete()
function Entity:delete()
  for i = self._key+1, #Entities do
    Entities[i]._key = i - 1
  end
  Entities[self._key] = nil
  table.remove(Entities, self._key)
  return nil
end

