require 'Libraries/bulletType'

local frame = 0

local knives = {}
local bknives = {}

Arena.Resize(150,200)

function Update()
  frame = frame + 1

  if frame % 10 == 0 then
    local knife = SetNotime("knifed",math.random(-Arena.width/2,Arena.width/2),Arena.height*2)
    knife.SetVar('spawn',frame)
    knife.ppcollision = true
    table.insert(knives,knife)
  end

  for i=1,#knives do
    if knives[i].isactive then
      knives[i].Move(0,-6)
      if frame - knives[i].GetVar('spawn') >= 100 then
        knives[i].sprite.alpha = knives[i].sprite.alpha - 0.1
        if knives[i].sprite.alpha == 0 then
          knives[i].Remove()
        end
      end
    end
  end

  if frame%50 == 0 then
    local knifel = SetBeam("rknifel",320,Player.y)
    knifel.SetVar("dir",-1)
    knifel.SetVar('spawn',frame)
    local knifer = SetBeam("rknifer",-320,Player.y)
    knifer.SetVar("dir",1)
    knifer.SetVar('spawn',frame)
    table.insert(bknives,knifel)
    table.insert(bknives,knifer)
  end

  for i=1,#bknives do
    if bknives[i].isactive then
      bknives[i].Move(10*bknives[i].GetVar("dir"),0)
      if frame - bknives[i].GetVar('spawn') >= 100 then
        bknives[i].sprite.alpha = bknives[i].sprite.alpha - 0.1
        if bknives[i].sprite.alpha == 0 then
          bknives[i].Remove()
        end
      end
    end
  end

  if frame == 640 then
    EndWave()
  end
end

function OnHit(bullet)
  Hit(bullet)
end