--Enemies class

--First we set the seed.
math.randomseed(os.time())

function newEnemy()        
    
    enemies.shots = {}
    
    for i=0,math.random(0,5) do
            enemy = {}
            enemy.image = love.graphics.newImage("img/enemy.png")
            enemy.x =  math.random(0,love.graphics.getWidth())
            enemy.y = 0
            enemy.isShooting = false
            enemy.timeToNextShot = 5
            enemy.speed = math.random(1, 3)
            enemy.verso = math.random(1, 2)
            table.insert(enemies, enemy)
    end
    
end

function enemyUpdate()
    
    local numEnemy = 0
    
    for k, val in ipairs(enemies) do
        numEnemy = numEnemy + 1
    end
    
    if(numEnemy < 3) then
        newEnemy()
    end
    
    for i, v in ipairs(enemies) do
        
        if(v.verso == 1) then
            v.x = v.x + 1
        else
            v.x = v.x -1
        end
        
        v.y = v.y + v.speed        
        
        --Shoots movement

        --Try to randomize shooting
        --
        --Basic ai
        --if(math.floor(math.random() * 99) == 5) then
        if (v.y - 30 < hero.y and v.y + 30 > hero.y) then
            enemyShoot(v)
        end
                
        if(v.y > love.graphics.getHeight()) then
            table.remove(enemies, i)
        end
        
    end
    
end

function enemyShoot(a)

    if(a.isShooting == false) then
	--for i=0, 1 do
            local shot = {}
            local shot2 = {}
            shot.image = love.graphics.newImage("img/bullet.png")	
            shot.x = a.x + a.image:getWidth()/3
            shot.y = a.y
            shot.side = "left"
            table.insert(enemies.shots, shot)
            
            shot2.image = love.graphics.newImage("img/bullet.png")	
            shot2.x = a.x + a.image:getWidth()/3
            shot2.y = a.y
            shot.side = "right"
            table.insert(enemies.shots, shot2)
            
            a.isShooting = true
        --end
    end
    
end
