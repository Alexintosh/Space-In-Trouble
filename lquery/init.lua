local easing = require("lquery.easing")
require("lquery.array")
require("lquery.entity")
G = love.graphics --graphics

local function animate(ent, time)
  if ent._animQueue then
    for i, j in pairs(ent._animQueue) do
      if j[1] then 
        aq = j[1]
        if not aq.lasttime then 
          aq.lasttime = time
          for k, v in pairs(aq.keys) do
            aq.old[k] = ent[k]
          end
        end
        
        if aq.lasttime + aq.speed <= time then
          table.remove(j, 1)
          for k, v in pairs(aq.keys) do
            ent[k] = v
          end 
          if aq.callback then aq.callback(ent) end
        else
          if aq.keys then
            for k, v in pairs(aq.keys) do
              ent[k] = easing[aq.easing](time - aq.lasttime, aq.old[k], v - aq.old[k], aq.speed)
            end
          end
        end --if aq.lasttime + vv.speed <= time
      end
    end  
  end --if ent._animQueue
end

local MousePressed = false

function love.run()
  if love.load then love.load(arg) end

  local dt = 0
  local time = 0
  -- Main loop time.
  while true do
    if love.timer then
      love.timer.step()
      dt = love.timer.getDelta()
    end
    if love.update then
      love.update(dt)
    end
    -- Process events.
    
    if love.event then
      for e,a,b,c in love.event.poll() do
        if e == "q" then
          if not love.quit or not love.quit() then
            if love.audio then
              love.audio.stop()
            end
            return
          end
        end
        if e == "mp" then MousePressed = true end
        if e == "mr" then MousePressed = false end
        love.handlers[e](a,b,c)
      end
    end
    local mX = love.mouse.getX()
    local mY = love.mouse.getY()
    if love.graphics then
      love.graphics.clear()
      time = love.timer.getTime()
      if Entities then
        
        for k, v in pairs(Entities) do
          --animate
          animate(v, time)
          
          --some mouse events
          if v._control then --if mouse controlled
            if (v.w 
                and v.h 
                and v.x < mX 
                and v.y < mY 
                and v.x + v.w > mX 
                and v.y +v.h >mY) or 
                v.R and 
                (math.pow(mX-v.x, 2)+math.pow(mY-v.y, 2) < v.R*v.R) then
              if MousePressed == true then
                if not v._mousePress or v._mousePress == false then
                  v._mousePress = true
                end
              else
                if v._mousePress == true then
                  if v._click then v._click(v, mX, mY) end
                  print('click')
                end
                v._mousePress = false
              end
              if not v._hasMouse or v._hasMouse == false then
                v._hasMouse = true
                if v._mouseover then v._mouseover(v, mX, mY) end
              end
            else
              v._mousePress = false
              if v._hasMouse and v._hasMouse == true then
                v._hasMouse = false
                if v._mouseout then v._mouseout(v, mX, mY) end
              end
            end
          end
          v:draw()
        end --for
      end --if Entities
      if love.draw then love.draw() end
    end --if love.graphics

    

    --if love.timer then love.timer.sleep(1) end
    if love.graphics then love.graphics.present() end

  end
end
