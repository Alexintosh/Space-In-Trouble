bulletSpeed = 10
b_x = 0
b_y = 0
isFiring = false

function newBullet(x, y)

	bullets = {}
	for i=0,50 do
		bullet = {}
		bullet.image = love.graphics.newImage("img/bullet.png");
		bullet.x = hero_x
		bullet.y = hero_y
		bullet.visible = false
		table.insert(bullets, bullet)
	end
    
    if(isFiring == false) then
        local bullet = love.graphics.newImage("img/bullet.png");
        b_x = x
        b_y = y
        return bullet        
    end    

end

function bulletUpdate()
        isFiring = true
	b_y = b_y - bulletSpeed
        
        if(b_y < 0) then
            isFiring = false
        end
        
end



function delBullet()
    
    if(isFiring == false) then
        bullet = love.graphics.clear ();
    end
    
end
