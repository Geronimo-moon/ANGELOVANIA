require 'Libraries/bulletType'
require 'Libraries/hsvToRgb'

Arena.Resize(280,300)

local frame = 0
local uknives = {SetBeam("rknifeu",50,358),SetBeam("rknifeu",50,258),SetBeam("rknifeu",50,158),SetBeam("rknifeu",50,58),SetBeam("rknifeu",50,-42),SetBeam("rknifeu",50,-142),SetBeam("rknifeu",50,-242)}
local dknives = {SetBeam("rknifed",-50,388),SetBeam("rknifed",-50,288),SetBeam("rknifed",-50,188),SetBeam("rknifed",-50,88),SetBeam("rknifed",-50,-12),SetBeam("rknifed",-50,-112),SetBeam("rknifed",-50,-212)}
local warning = {}
local knives = {}
local place = 0

function Update()
  frame = frame + 1

  for i=1,#uknives do
    if uknives[i].isactive then
      uknives[i].Move(0,2)
      uknives[i].ppcollision = true
      if uknives[i].absy >= 544 then
        uknives[i].Remove()
      end
    end
  end

  for i=1,#dknives do
    if dknives[i].isactive then
      dknives[i].ppcollision = true
      dknives[i].Move(0,-2)
      if dknives[i].absy <= -64 then
        dknives[i].Remove()
      end
    end
  end

  if frame%50 == 45 then
    local uknife = SetBeam("rknifeu",50,-342)
    table.insert(uknives,uknife)
    local dknife = SetBeam("rknifed",-50,318)
    table.insert(dknives,dknife)
  end

  if frame%60 == 0 then
    if Player.x <= -50 then
      place = 0
    elseif Player.x >= 50 then
      place = 2
    else
      place = 1
    end
    local warn = SetSprite('warnbox',100*place-100,-100)
    warn.SetVar("spawn",frame)
    table.insert(warning,warn)
    Audio.PlaySound('BeginBattle1')
  end

  for i=1,#warning do
    if warning[i].isactive then
      local spawn = warning[i].GetVar('spawn')
      warning[i].sprite.color = hsvToRgb((spawn+30-frame)*2,255,255)
      if spawn+30-frame == 0 then
        warning[i].Remove()
        local x = -140+100*place
        for j=1,5 do
          for k=1,5 do
            local knife = SetNotime("knifed",x+k*20-20,298+64*(j-1))
            table.insert(knives,knife)
          end
        end
      end
    end
  end

  for i=1,#knives do
    if knives[i].isactive then
      knives[i].Move(0,-15)
      if knives[i].absy <= -64 then
        knives[i].Remove()
      end
    end
  end

  if frame == 600 then
    EndWave()
  end

end

function OnHit(bullet)
  Hit(bullet)
end