require 'Libraries.bulletType'
require 'Libraries.hsvToRgb'

Arena.Resize(250,110)
frame = 0
uknives = {}
dknives = {}
direction = 1
local warning

function Update()
  frame = frame + 1

  if frame % 40 == 1 then
    local uknife = SetNotime("knifed",120*(-1)^(direction+1),30)
    local dknife = SetNotime("knifeu",-120*(-1)^(direction+1),-30)
    uknife.ppcollision = true
    dknife.ppcollision = true
    table.insert(uknives,uknife)
    table.insert(dknives,dknife)
  end

  for i=1,#uknives do
    if uknives[i].isactive then
      local y = -1/2*(math.sin(math.pi*i/4))^2
      uknives[i].Move(5/2*(-1)^direction,y)
      if (uknives[i].x >= Arena.width/2 and direction == 2) or (uknives[i].x <= -Arena.width/2 and direction == 1) then
        uknives[i].Remove()
      end
    end
  end

  for i=1,#dknives do
    if dknives[i].isactive then
      local y = 1/2*(math.cos(math.pi*i/4))^2
      dknives[i].Move(-5/2*(-1)^direction,y)
      if (dknives[i].x >= Arena.width/2 and direction == 1) or (dknives[i].x <= -Arena.width/2 and direction == 2)  then
        dknives[i].Remove()
      end
    end
  end

  if frame == 240 then
    warning = SetSprite("warnbox4",0,0)
    Audio.PlaySound('BeginBattle1')
  end

  if frame >= 240 and 300 >= frame then
    warning.sprite.color = hsvToRgb(300-frame,255,255)
  end

  if frame == 300 then
    direction = direction + 1
    warning.Remove()
  end

  if frame == 600 then
    EndWave()
  end
end

function OnHit(bullet)
  Hit(bullet)
end