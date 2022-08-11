require 'Libraries/bulletType'

local frame = 0
local knives = {}

Arena.Resize(140,140)

SetPPCollision(true)

local box = SetSprite("empty", 0,0,"BelowBullet")
box.sprite.Mask("box")
box.sprite.Scale(Arena.width/box.sprite.width, Arena.height/box.sprite.height)

function Update()
  box.MoveTo(0,0)
  frame = frame + 1

  if frame % 30 == 0 then
    local theta = math.random()*math.pi
    local pos = math.random(-60,30)
    local x = 150*math.cos(theta + math.pi/2)
    local y = 150*math.sin(theta + math.pi/2)
    local knife = {SetBeam('rknifer',x+(pos-64)*math.cos(theta),y+(pos-64)*math.sin(theta)),SetBeam('rknifel',x+(pos+94)*math.cos(theta),y+(pos+94)*math.sin(theta))}
    knife[1].sprite.rotation = theta/math.pi*180
    knife[2].sprite.rotation = theta/math.pi*180
    knife[1].sprite.SetParent(box.sprite)
    knife[2].sprite.SetParent(box.sprite)
    knife[1].sprite.Scale(2,1)
    knife[2].sprite.Scale(2,1)
    table.insert(knife,theta+math.pi/2)
    table.insert(knives,knife)
  end

  for i=1,#knives do
    if knives[i][1].isactive then
      for j=1,2 do
        knives[i][j].Move(-2*math.cos(knives[i][3]),-2*math.sin(knives[i][3]))
      end
    end
  end

  if frame == 750 then
    EndWave()
  end
end

function OnHit(bullet)
  Hit(bullet)
end