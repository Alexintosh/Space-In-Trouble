function Objs()

    keypressed()
    
    if(isGameOver == true) then
        return false
    end
    
    playerUpdate()
    enemyUpdate()
    loop()
    love.timer.sleep(1000 / 50) -- 60 FPS
    
end

function setup()
        godMode = false
        _W = love.graphics.getWidth()
        _H = love.graphics.getHeight()
        enemies = {}
        isGameOver = false
        --shotSound = love.sound.newSource("asplode.wav", "static"):play()
	love.graphics.setMode(640, 480, false, true, 0)
	love.graphics.setCaption("Space in trouble!")
        bg = love.graphics.newImage("img/bg2.png")
        newEnemy()
        newPlayer()        

end


function keypressed( k )

   if love.keyboard.isDown("r") then
      love.run()
   end
   
   if love.keyboard.isDown("q") then
      love.event.push('q')
   end
   
   if love.keyboard.isDown("g") then
        godMode = true            
   end
   
   if love.keyboard.isDown("h") then
        godMode = false            
   end
   
   
end

function loop()

    local remEnemy = {}
    local remShot = {}
    local remEnemyShot = {}
    bulletSpeed = 10
    
    
    for i,v in ipairs(hero.shots) do
    
            v.y = v.y - bulletSpeed

            if (v.y < 0) or (v.x < 5) or (v.x > _W) then
		table.insert(remShot, i)
	    end
            
            -- check collision with enemies
            for ii,vv in ipairs(enemies) do
                    
                    if (CheckCollision(v.x, v.y, v.image:getWidth(), v.image:getHeight(), vv.x ,vv.y , vv.image:getWidth(), vv.image:getHeight()) == true) then
                            -- mark that enemy for removal
                            table.insert(remEnemy, ii)
                            table.insert(remShot, i)
                            TEsound.play("asplode.wav")
                    end
                    
            end
    end
    
    for i,v in ipairs(remEnemy) do
	table.remove(enemies, v)
    end
        
    for i,v in ipairs(remShot) do
	table.remove(hero.shots, v)
    end
    
    for i,v in ipairs(enemies.shots) do

        if(v.side == "right") then
            v.x = v.x + math.random(2, 10)
        else
            v.x = v.x - math.random(2, 10)
        end
        

        if (CheckCollision(v.x, v.y, v.image:getWidth(), v.image:getHeight(), hero.x ,hero.y , hero.image:getWidth(), hero.image:getHeight()) == true) then
            isGameOver = true
        end        
        
    end
    
    for i,v in ipairs(remEnemyShot) do
        table.remove(enemies.shots, i)
    end
    
                
end

function CheckCollision(box1x, box1y, box1w, box1h, box2x, box2y, box2w, box2h)
    if box1x > box2x + box2w - 1 or -- Is box1 on the right side of box2?
       box1y > box2y + box2h - 1 or -- Is box1 under box2?
       box2x > box1x + box1w - 1 or -- Is box2 on the right side of box1?
       box2y > box1y + box1h - 1    -- Is b2 under b1?
    then
        return false                -- No collision. Yay!
    else
        return true                 -- Yes collision. Ouch!
    end
end
