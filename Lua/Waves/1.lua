require 'Libraries/bulletType'

Arena.Resize(250,250)
local frame = 0
local knives = {}

function Update()
  frame = frame + 1

  if frame % 14 == 3 then
    local spawn = math.random(-Arena.height/2,Arena.height/2)
    for i=1,9 do
      local knife = SetNotime("knifer",Arena.width,spawn)
      knife.ppcollision = true
      knife.SetVar("angle",(i-1)*40)
      knife.sprite.rotation = (i-1)*40
      table.insert(knives,knife)
    end
  end

  if frame % 14 == 10 then
    local spawn = math.random(-Arena.height/2,Arena.height/2)
    for i=1,9 do
      local knife = SetNotime("knifer",-Arena.width,spawn)
      knife.ppcollision = true
      knife.SetVar("angle",(i-1)*40)
      knife.sprite.rotation = (i-1)*40
      table.insert(knives,knife)
    end
  end

  for i=1,#knives do
    if knives[i].isactive then
      local theta = math.pi*knives[i].GetVar("angle")/180
      local x = 6*math.cos(theta)
      local y = 6*math.sin(theta)
      knives[i].Move(x,y)

      if knives[i].absx <= 0 or knives[i].absx >= 640 or knives[i].absy <= 0 or knives[i].absy >= 480 then
        knives[i].Remove()
      end
    end
  end

  if frame == 500 then
    EndWave()
  end
end

function OnHit(bullet)
  Hit(bullet)
end