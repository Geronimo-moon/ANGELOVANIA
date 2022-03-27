require 'Libraries.bulletType'
require 'Libraries.hsvToRgb'

Arena.Resize(280,300)

frame = 0
uknives = {SetBeam("rknifeu",50,298),SetBeam("rknifeu",50,208),SetBeam("rknifeu",50,118),SetBeam("rknifeu",50,28),SetBeam("rknifeu",50,-62),SetBeam("rknifeu",50,-152),SetBeam("rknifeu",50,-242)}
dknives = {SetBeam("rknifeu",-50,388),SetBeam("rknifeu",-50,298),SetBeam("rknifeu",-50,208),SetBeam("rknifeu",-50,118),SetBeam("rknifeu",-50,28),SetBeam("rknifeu",-50,-62),SetBeam("rknifeu",-50,-152)}
warning = {}
knives = {}
place = 0

function Update()
  frame = frame + 1

  for i=1,#uknives do
    if uknives[i].isactive then
      uknives[i].Move(0,2)
      if uknives[i].absy >= 544 then
        uknives[i].Remove()
      end
    end
  end

  for i=1,#dknives do
    if dknives[i].isactive then
      dknives[i].Move(0,-2)
      if dknives[i].absy <= -64 then
        dknives[i].Remove()
      end
    end
  end

  if frame%45 == 0 then
    local uknife = SetBeam("rknifeu",50,-242)
    table.insert(uknives,uknife)
    local dknife = SetBeam("rknifeu",-50,298)
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