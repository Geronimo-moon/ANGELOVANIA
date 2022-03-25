require 'Libraries.bulletType'

frame = 0
knives = {}

Arena.Resize(400,350)

function Update()
  frame = frame + 1

  if frame % 50 == 5 then
    local xTo,yTo = Player.x,Player.y
    for i=1,8 do
      local x = xTo+200*math.cos(math.pi*i/4+math.pi/8)
      local y = yTo+200*math.sin(math.pi*i/4+math.pi/8)
      local knife = SetNotime("knifel",x,y)
      knife.ppcollision = true
      knife.SetVar('theta',math.pi*i/4+math.pi/8)
      knife.SetVar('spawn',frame)
      knife.sprite.rotation = 45*i+22.5
      table.insert(knives,knife)
    end
  end

  if frame % 50 == 30 then
    local xTo,yTo = Player.x,Player.y
    for i=1,8 do
      local x = xTo+200*math.cos(math.pi*i/4)
      local y = yTo+200*math.sin(math.pi*i/4)
      local knife = SetNotime("knifel",x,y)
      knife.ppcollision = true
      knife.SetVar('theta',math.pi*i/4)
      knife.SetVar('spawn',frame)
      knife.sprite.rotation = 45*i
      table.insert(knives,knife)
    end
  end

  for i=1,#knives do
    if knives[i].isactive then
      local theta = knives[i].GetVar('theta')
      local x = -3*math.cos(theta)
      local y = -3*math.sin(theta)
      knives[i].Move(x,y)
      if frame - knives[i].GetVar('spawn') >= 120 then
        knives[i].sprite.alpha = knives[i].sprite.alpha -0.1
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