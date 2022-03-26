require 'Libraries.bulletType'

frame = 0
knives = {}

Arena.Resize(250,250)

function Update()
  frame = frame + 1

  if frame % 50 == 10 then
    local xTo,yTo = Player.x,Player.y
    for i=1,8 do
      local x = xTo+250*math.cos(math.pi*i/4+math.pi/8)
      local y = yTo+250*math.sin(math.pi*i/4+math.pi/8)
      local knife = SetNotime("knifel",x,y)
      knife.ppcollision = true
      knife.SetVar('theta',math.pi*i/4+math.pi/8)
      knife.SetVar("to",{xTo,yTo})
      knife.SetVar("dir",1)
      knife.sprite.rotation = 45*i+22.5
      table.insert(knives,knife)
    end
  end

  if frame % 50 == 35 then
    local xTo,yTo = Player.x,Player.y
    for i=1,8 do
      local x = xTo+250*math.cos(math.pi*i/4)
      local y = yTo+250*math.sin(math.pi*i/4)
      local knife = SetNotime("knifel",x,y)
      knife.ppcollision = true
      knife.SetVar('theta',math.pi*i/4)
      knife.SetVar("to",{xTo,yTo})
      knife.SetVar("dir",0)
      knife.sprite.rotation = 45*i
      table.insert(knives,knife)
    end
  end

  for i=1,#knives do
    if knives[i].isactive then
      local theta = knives[i].GetVar('theta')
      local xTo,yTo = knives[i].GetVar('to')[1], knives[i].GetVar('to')[2]
      local diff = math.sqrt((xTo-knives[i].x)^2+(yTo-knives[i].y)^2)
      local dir = (-1)^knives[i].GetVar("dir")
      local x = (diff*976/1000)*math.cos(theta+math.pi/90*dir) + xTo
      local y = (diff*976/1000)*math.sin(theta+math.pi/90*dir) + yTo
      knives[i].MoveTo(x,y)
      knives[i].SetVar('theta',theta+math.pi/90*dir)
      knives[i].sprite.rotation = knives[i].sprite.rotation + 2*dir
      if diff <= 20 then
        knives[i].sprite.alpha = knives[i].sprite.alpha - 0.1
        if knives[i].sprite.alpha == 0 then
          knives[i].Remove()
        end
      end
    end
  end

  if frame >= 600 then
    EndWave()
  end

end

function OnHit(bullet)
  Hit(bullet)
end