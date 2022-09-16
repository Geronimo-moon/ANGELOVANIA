require 'Libraries/bulletType'

Arena.Resize(170,150)

local frame = 0

local knives = {}
local uknives = {}
local dknives = {}

SetPPCollision(true)

local box = SetSprite("empty", 0,0,"BelowBullet")
box.sprite.Mask("box")
box.sprite.Scale(Arena.width/box.sprite.width, Arena.height/box.sprite.height)

function Update()
  frame = frame + 1
  box.MoveTo(0,0)

  if frame % 2 == 0 and frame <= 600 then
    local uknife = SetBeam('rknifed',Arena.width/2,Arena.height/2.2-22*math.sin(frame/10))
    local dknife = SetBeam('rknifeu',Arena.width/2,-Arena.height/2.2-22*math.sin(frame/10))
    uknife.sprite.Scale(1,1.6)
    dknife.sprite.Scale(1,1.6)
    uknife.sprite.SetParent(box.sprite)
    dknife.sprite.SetParent(box.sprite)
    uknife.SetVar('spawn',frame)
    dknife.SetVar('spawn',frame)
    table.insert(knives,uknife)
    table.insert(knives,dknife)
  end


  for i = 1, #knives do
    if knives[i].isactive then
      local spawn = knives[i].GetVar('spawn')
      knives[i].Move(0.05*(frame-spawn-80),0)
      if knives[i].x >= 200 then
        knives[i].Remove()
      end
    end
  end

  if frame == 700 then
    for i = 0, 4 do
      local uknife = SetBeam('rknifed',-85+40*i,300)
      table.insert(uknives,uknife)
    end
    for i = 0, 3 do
      local dknife = SetBeam('rknifeu',-85+40*i+20,-300)
      table.insert(dknives,dknife)
    end
  end

  for i = 1, #uknives do
    uknives[i].Move(0,-4)
  end
  for i = 1, #dknives do
    dknives[i].Move(0,4)
  end

  if frame == 800 then
    EndWave()
  end
end

function OnHit(bullet)
  Hit(bullet)
end