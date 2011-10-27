--Define the player

function newPlayer()
    
    hero = {}
    hero.image = love.graphics.newImage("img/player.png")
    hero.x =  292
    hero.y = 466
    hero.speed = 0.5
    hero.width = hero.image:getWidth()
    hero.shots = {}
    timeToNextShot = 0    
    vx = 0
    vy = 0
    friction = 0.93
    maxspeed = 6
    bulletSpeed = 10
    shooting = false
    
end

function playerUpdate()
--Player movements

    if(isGameOver == true) then
        return false
    end

    if love.keyboard.isDown("left") then
	  vx = vx - hero.speed
	elseif love.keyboard.isDown("right") then
		vx = vx + hero.speed
	else
		vx = vx * friction
	end
	
	
	if love.keyboard.isDown("up") then
		vy = vy - hero.speed
	elseif love.keyboard.isDown("down") then
		vy = vy + hero.speed
	else
		vy = vy * friction		
	end
	
	hero.x = hero.x + vx
	hero.y = hero.y + vy

--Check if player go out of the screen        

        if(hero.x < 0) then
            hero.x = love.graphics.getWidth()
        end
        
        if(hero.x > love.graphics.getWidth()) then
            hero.x = 0
        end
        
        if(hero.y < 0) then
            hero.y = love.graphics.getHeight()
        end
        
        if(hero.y > love.graphics.getHeight()) then
            hero.y = 0
        end        

-- stop check

	if (vy > maxspeed) then
		vy = maxspeed
	elseif (vx < -maxspeed) then
		vx = -maxspeed
	end
        
        if love.keyboard.isDown(" ")  then
            if(shooting == false) then
                timeToNextShot = 5
                shoot()
            end

	end        
        
        
--Shoots movement
        if(shooting == true) then
            timeToNextShot = timeToNextShot - 1
            
            if(timeToNextShot < 0) then
                timeToNextShot = 50
                shooting = false
            end
        end

--Check if game over

    if(godMode == false) then
        for ii,vv in ipairs(enemies) do
                    
                if (CheckCollision(hero.x, hero.y, hero.image:getWidth(), hero.image:getHeight(), vv.x ,vv.y , vv.image:getWidth(), vv.image:getHeight()) == true) then
                        print('FAIL')
                        isGameOver = true
                        -- mark that enemy for removal
                        table.insert(remEnemy, ii)
                        
                end
        end
    end        
        
end

function shoot()
    if(shooting == false) then
	local shot = {}
	shot.image = love.graphics.newImage("img/bullet.png")	
	shot.x = hero.x + hero.width/3
	shot.y = hero.y
	table.insert(hero.shots, shot)
        shooting = true
    end
end
