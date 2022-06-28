require 'Libraries/bulletType'

Arena.Resize(80,80)

local frame = 0
local speed = 1

local knives = {}
local fastknives = {}
local lastb = {}
local lastv = {}

function Update()
  frame = frame + 1

  if frame == 5 then
    if math.random(1,2) == 1 then
      local knife1 = SetBeam('rknifel',100,0)
      knife1.SetVar('dir','left')
      table.insert(fastknives,knife1)
      local knife2 = SetBeam('rknifer',-90,25)
      local knife3 = SetBeam('rknifer',-90,-25)
      knife2.SetVar('dir','right')
      knife3.SetVar('dir','right')
      table.insert(knives,knife2)
      table.insert(knives,knife3)
    else
      local knife1 = SetBeam('rknifer',-100,0)
      knife1.SetVar('dir','right')
      table.insert(fastknives,knife1)
      local knife2 = SetBeam('rknifel',90,25)
      local knife3 = SetBeam('rknifel',90,-25)
      knife2.SetVar('dir','left')
      knife3.SetVar('dir','left')
      table.insert(knives,knife2)
      table.insert(knives,knife3)
    end
  end

  if frame >= 70 and frame <= 500 then
    speed = 2
    if frame % 30 == 10 then
      local rd = math.random(1,4)
      local path,dir,x,y
      if rd == 1 then
        path = 'knifeu'
        dir = 'up'
        x = Player.x
        y = -80
      elseif rd == 2 then
        path = 'knifed'
        dir = 'down'
        x = Player.x
        y = 80
      elseif rd == 3 then
        path = 'knifel'
        dir = 'left'
        y = Player.y
        x = 80
      elseif rd == 4 then
        path = 'knifer'
        dir = 'right'
        y = Player.y
        x = -80
      end
      local knife = SetNotime(path,x,y)
      knife.SetVar('dir',dir)
      if math.random(1,2) == 1 then
        table.insert(fastknives,knife)
      else
        table.insert(knives,knife)
      end
    end
  end

  for i=1,#knives do
    if knives[i].isactive then
      local dir = knives[i].GetVar('dir')
      if dir == 'left' then
        knives[i].Move(-2*speed,0)
      elseif dir == 'right' then
        knives[i].Move(2*speed,0)
      elseif dir == 'up' then
        knives[i].Move(0,2*speed)
      elseif dir == 'down' then
        knives[i].Move(0,-2*speed)
      end

      if knives[i].absx <= 0 or knives[i].absx >= 640 or knives[i].absy <= 0 or knives[i].absy >= 480 then
        knives[i].Remove()
      end
    end
  end

  for i=1,#fastknives do
    if fastknives[i].isactive then
      local dir = fastknives[i].GetVar('dir')
      if dir == 'left' then
        fastknives[i].Move(-3*speed,0)
      elseif dir == 'right' then
        fastknives[i].Move(3*speed,0)
      elseif dir == 'up' then
        fastknives[i].Move(0,3*speed)
      elseif dir == 'down' then
        fastknives[i].Move(0,-3*speed)
      end
    end

    if fastknives[i].absx <= 0 or fastknives[i].absx >= 640 or fastknives[i].absy <= 0 or fastknives[i].absy >= 480 then
      fastknives[i].Remove()
    end
  end

  if frame == 550 then
    for i=1,2 do
      local knifer = SetBeam('rknifer',-320,-10+(20*(i-1)))
      local knifel = SetBeam('rknifel',320,-10+(20*(i-1)))
      local knifeu = SetBeam('rknifeu',-10+(20*(i-1)),-320)
      local knifed = SetBeam('rknifed',-10+(20*(i-1)),320)
      table.insert(lastb,knifer)
      table.insert(lastb,knifel)
      table.insert(lastv,knifeu)
      table.insert(lastv,knifed)
    end
  end

  for i=1,#lastv do
    if lastv[i].isactive then
      lastv[i].MoveTo(lastv[i].x,lastv[i].y/2)
    end
  end

  for i=1,#lastb do
    if lastb[i].isactive then
      lastb[i].MoveTo(lastb[i].x/2,lastb[i].y)
    end
  end

  if frame == 630 then
    EndWave()
  end

end

function OnHit(bullet)
  Hit(bullet)
end