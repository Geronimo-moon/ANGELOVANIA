require 'Libraries/bulletType'

Arena.Resize(200,160)

local frame = 0

local flames = {}
local knives = {}

local indexFlame = 5
local increment = 1

local tori = require 'Animations/backMonster'
tori.init('monsters/tori')

function Update()
  tori.update(frame)
  frame = frame + 1

  if frame % 5 == 0 then
    for i=0,indexFlame-1 do
      local flame = SetDefault("attack/flame",-Arena.width/2+8+15*i,Arena.height/2+8)
      table.insert(flames,flame)
    end

    for i=0,9-indexFlame do
      local flame = SetDefault("attack/flame",Arena.width/2-8-15*i,Arena.height/2+8)
      table.insert(flames,flame)
    end

    if increment == 0 then
      if indexFlame == 8 then
        increment = -1
      elseif indexFlame == 3 then
        increment = 1
      end
    end

    if indexFlame == 8 and increment == 1 then
      increment = 0
    elseif indexFlame == 3 and increment == - 1 then
      increment = 0
    end
    indexFlame = indexFlame + increment
  end

  for i=1,#flames do
    if flames[i].isactive then
      flames[i].Move(0,-3)
      if flames[i].y <= -Arena.height/2 then
        flames[i].Remove()
      end
    end
  end

  if frame >= 100 and frame % 50 == 0 then
    Audio.PlaySound('fly')
    local knifel = SetNotime("knifel",320,Player.y)
    knifel.SetVar("dir",-1)
    knifel.SetVar('spawn',frame)
    local knifer = SetNotime("knifer",-320,Player.y)
    knifer.SetVar("dir",1)
    knifer.SetVar('spawn',frame)
    table.insert(knives,knifel)
    table.insert(knives,knifer)
  end

  for i=1,#knives do
    if knives[i].isactive then
      knives[i].Move(10*knives[i].GetVar("dir"),0)
      if frame - knives[i].GetVar('spawn') >= 100 then
        knives[i].sprite.alpha = knives[i].sprite.alpha - 0.1
        if knives[i].sprite.alpha == 0 then
          knives[i].Remove()
        end
      end
    end
  end

  if frame == 650 then
    tori.destroy()
    EndWave()
  end
end

function OnHit(bullet)
  Hit(bullet)
end