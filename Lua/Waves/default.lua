require 'Libraries/bulletType'

Arena.Resize(200,100)
local frame = 0
local uknives = {}
local dknives = {}
local direction = 1

function Update()
  frame = frame + 1

  if frame % 36 == 0 then
    local uknife = SetNotime("knifed",100,30)
    local dknife = SetNotime("knifeu",-100,-30)
    uknife.ppcollision = true
    dknife.ppcollision = true
    table.insert(uknives,uknife)
    table.insert(dknives,dknife)
  end

  for i=1,#uknives do
    if uknives[i].isactive then
      uknives[i].Move(3*(-1)^direction,0)
      if uknives[i].x <= -Arena.width/2 then
        uknives[i].Remove()
      end
    end
  end

  for i=1,#dknives do
    if dknives[i].isactive then
      dknives[i].Move(-3*(-1)^direction,0)
      if dknives[i].x >= Arena.width/2  then
        dknives[i].Remove()
      end
    end
  end

  if frame == 500 then
    EndWave()
  end
end

function OnHit(bullet)
  Hit(bullet)
  if GetGlobal('phase') ~= 1 then
    local kr
    if Encounter["debugging"] or bullet.GetVar("type") == "sprite" then
      kr = 0
    elseif Encounter["noob"] or Encounter["ez"] then
      kr = 3
    else
      kr = 6
    end
    Encounter.Call("Karma_Inc", kr)
  end
end