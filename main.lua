--My first Lua project
--
--Title:
--
--Space in trouble!
--
--Coded by Alessio Delmonti
--www.tecnocrazia.com

require "LICK"
require "LICK/lib"
require "TEsound"
--require "lquery.init"

lick.reset = true

require("tools.lua")
require("player.lua")
require("enemy.lua")


function love.load()
    setup()
end

function love.draw()
    love.graphics.draw(bg) 
    love.graphics.draw(hero.image, hero.x, hero.y)    
    
--  Bullets hero drawing  
    for i,v in ipairs(hero.shots) do
            love.graphics.draw(v.image, v.x, v.y)
    end
    
--  Bullets enemies drawing    
    for i, v in ipairs(enemies.shots) do
        love.graphics.draw(v.image, v.x, v.y)
    end    

--  Enemies drawing  
    for i,v in ipairs(enemies) do
            love.graphics.draw(v.image, v.x, v.y)
    end    
end

function love.update()
    TEsound.cleanup()
    Objs()
end
