require 'Libraries/bulletType'

Arena.Resize(250,250)
frame = 0
knives = {}

function Update()
  frame = frame + 1

  if frame % 16 == 3 then
    local spawn = math.random(-Arena.height/2,Arena.height/2)
    local angle = math.random(0,359)
    local color = "white"
    local path = "knifer"
    for i=1,10 do
      if i==(angle+5)%10 or i==(angle+6)%10 then
        color = "blue"
        path = "bknifer"
      elseif i==(angle+9)%10 or i==(angle+10)%10 then
        color = "orange"
        path = "oknifer"
      else
        color = "white"
        path = "knifer"
      end
      local knife = SetNotime(path,Arena.width,spawn,"",color)
      knife.ppcollision = true
      knife.SetVar("dir",math.random(0,1))
      knife.SetVar("angle",(i-1)*36+angle)
      knife.sprite.rotation = (i-1)*36+angle
      table.insert(knives,knife)
    end
  end

  if frame % 16 == 11 then
    local spawn = math.random(-Arena.height/2,Arena.height/2)
    local angle = math.random(0,359)
    local color = "white"
    local path = "knifer"
    for i=1,10 do
      if i==(angle+5)%10 or i==(angle+6)%10 then
        color = "blue"
        path = "bknifer"
      elseif i==(angle+9)%10 or i==(angle+10)%10 then
        color = "orange"
        path = "oknifer"
      else
        color = "white"
        path = "knifer"
      end
      local knife = SetNotime(path,-Arena.width,spawn,'',color)
      knife.ppcollision = true
      knife.SetVar("dir",math.random(0,1))
      knife.SetVar("angle",(i-1)*36+angle)
      knife.sprite.rotation = (i-1)*36+angle
      table.insert(knives,knife)
    end
  end

  for i=1,#knives do
    if knives[i].isactive then
      local rd = knives[i].GetVar('dir')
      local theta = math.pi*knives[i].GetVar("angle")/180 + math.pi/120*(-1)^rd
      local x = 7*math.cos(theta)
      local y = 7*math.sin(theta)
      knives[i].Move(x,y)

      knives[i].SetVar("angle",knives[i].GetVar("angle")+3/2*(-1)^rd)
      knives[i].sprite.rotation = knives[i].GetVar("angle")

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