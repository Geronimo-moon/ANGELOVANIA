require 'Libraries/bulletType'

frame = 0

Arena.Resize(300,200)

knives = {}
shadows = {}

function Update()
  frame = frame + 1

  if frame % 10 == 0 then
    local x,y
    while true do
      x = math.random(-320,320)
      y = math.random(-240,240)

      if not (x <= 150 and x >= -150 and y <= 100 and y >= -100) then
        break
      end
    end
    local tox = math.random(-Arena.width/2+10,Arena.width/2-10)
    local toy = math.random(-Arena.height/2+10,Arena.height/2-10)
    local dydx = (y-toy)/(x-tox)
    local dir = (tox-x)/math.abs(x-tox)
    local theta

    if dir == 1 then
      if math.atan(dydx) >= 0 then
        theta = math.atan(dydx)
      else
        theta = math.atan(dydx) + 2*math.pi
      end
    else
      theta = math.atan(dydx) + math.pi
    end

    local knife = SetNotime('knifer',x,y)
    knife.SetVar('theta',theta)
    knife.sprite.rotation = 180*theta/math.pi
    knife.ppcollision = true

    table.insert(knives,knife)
  end

  for i=1,#knives do
    if knives[i].isactive then
      local theta = knives[i].GetVar('theta')
      knives[i].Move(5*math.cos(theta),5*math.sin(theta))

      if knives[i].absx <= -64 or knives[i].absx >= 704 or knives[i].absy <= -64 or knives[i].absy >= 544 then
        knives[i].Remove()
      end

      if frame % 3 == 0 then
        local shadow = SetNotime('knifer',knives[i].x,knives[i].y)
        shadow.sprite.rotation = knives[i].sprite.rotation

        shadow.SetVar('spawn',frame)
        shadow.ppcollision = true
        table.insert(shadows,shadow)
      end
    end
  end

  for i=1,#shadows do
    if shadows[i].isactive then
      local spawn = shadows[i].GetVar('spawn')
      if (frame-spawn)%5 == 0 then
        shadows[i].sprite.alpha = shadows[i].sprite.alpha - 0.1

        if shadows[i].sprite.alpha == 0 then
          shadows[i].Remove()
        end
      end
    end
  end

  if frame == 700 then
    EndWave()
  end
end

function OnHit(bullet)
  Hit(bullet)
end