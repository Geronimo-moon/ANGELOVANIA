require 'Libraries.bulletType'

frame = 0
knives = {}

Arena.Resize(200,200)

function Update()
  frame = frame + 1

  if frame % 15 == 1 then
    local x,y
    while true do
      x = math.random(-320,320)
      y = math.random(-240,240)

      if not (x <= 150 and x >= -150 and y <= 150 and y >= -150) then
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
    knife.SetVar('speed',8)

    table.insert(knives,knife)
  end

  for i = 1 ,#knives do
    if knives[i].isactive then
      local theta = knives[i].GetVar('theta')
      knives[i].Move(knives[i].GetVar('speed')*math.cos(theta),knives[i].GetVar('speed')*math.sin(theta))

      if knives[i].GetVar('speed') == 8 and knives[i].x^2+knives[i].y^2 <= 10000 then
        local rknife = SetBeam('rknifer',knives[i].x,knives[i].y)
        rknife.SetVar('theta',theta)
        rknife.SetVar('speed',math.random(1,4))
        if math.random(10) == 1 then
          rknife.SetVar('speed',0)
        end
        rknife.sprite.rotation = 180*theta/math.pi
        rknife.ppcollision = true
        table.insert(knives,rknife)
        local bknife = SetBeam('bknifer',knives[i].x,knives[i].y,'','blue')
        bknife.SetVar('theta',theta+math.pi/6)
        bknife.SetVar('speed',math.random(1,5))
        bknife.sprite.rotation = 180*theta/math.pi+30
        bknife.ppcollision = true
        table.insert(knives,bknife)
        local oknife = SetBeam('oknifer',knives[i].x,knives[i].y,'','orange')
        oknife.SetVar('theta',theta-math.pi/6)
        oknife.SetVar('speed',math.random(1,5))
        oknife.sprite.rotation = 180*theta/math.pi-30
        oknife.ppcollision = true
        table.insert(knives,oknife)
        knives[i].Remove()
      end

      if knives[i].absx <= 0 or knives[i].absx >= 640 or knives[i].absy <= 0 or knives[i].absy >= 480 then
        knives[i].Remove()
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