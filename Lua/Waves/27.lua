require 'Libraries/bulletType'

Arena.Resize(90,90)

local soul = require 'Libraries/soulManager'
soul.Init({'green'})
soul.green.ChangeShield(2,false)

local frame = 0

local dyne = require 'Animations/backMonster'
dyne.init('monsters/dyne')

local spears = {}
local yspears = {}

function Update()
  soul.Update()
  dyne.update(frame)
  frame = frame + 1
  if Player.y ~= 0 then
    Player.MoveTo(0,0)
  end
  if Arena.y ~= 170 then
    Arena.MoveTo(320,170)
  end

  if frame % 11 == 0 and frame <= 349 then
    local pos,x,y
    local index = math.random(1,4)
    if index == 1 then
      pos = 'up'
      x = 0
      y = 300
    elseif index == 3 then
      pos = 'down'
      x = 0
      y = -300
    elseif index == 4 then
      pos = 'right'
      x = 300
      y = 0
    elseif index == 2 then
      pos = 'left'
      x = -300
      y = 0
    end
    local spear = SetDefault('attack/mspearb',x,y)
    spear.sprite.rotation = 90*index
    spear.SetVar('pos',pos)
    spear.SetVar('mv',{x=-x/350,y=-y/350})
    spear.SetVar('color','blue')
    table.insert(spears,spear)
  end

  if frame % 11 == 0 and frame > 349 then
    local pos,x,y
    local index = math.random(1,4)
    if index == 1 then
      pos = 'up'
      x = 0
      y = -300
    elseif index == 3 then
      pos = 'down'
      x = 0
      y = 300
    elseif index == 4 then
      pos = 'right'
      x = -300
      y = 0
    elseif index == 2 then
      pos = 'left'
      x = 300
      y = 0
    end
    local spear = SetDefault('attack/mspearby',x,y)
    spear.sprite.rotation = 90*index + 180
    spear.SetVar('theta',math.pi*index/2+math.pi)
    spear.SetVar('pos',pos)
    spear.SetVar('mv',{x=-x/330,y=-y/330})
    spear.SetVar('color','blue')
    spear.SetVar('spin',0)
    spear.SetVar('speed',1)
    table.insert(yspears,spear)
  end

  if frame % 12 == 7 and frame <= 349 then
    local pos,x,y
    local index = math.random(1,4)
    if index == 1 then
      pos = 'up'
      x = 0
      y = 300
    elseif index == 3 then
      pos = 'down'
      x = 0
      y = -300
    elseif index == 4 then
      pos = 'right'
      x = 300
      y = 0
    elseif index == 2 then
      pos = 'left'
      x = -300
      y = 0
    end
    local spear = SetDefault('attack/mspearr',x,y)
    spear.sprite.rotation = 90*index
    spear.SetVar('pos',pos)
    spear.SetVar('mv',{x=-x/120,y=-y/120})
    spear.SetVar('color','red')
    table.insert(spears,spear)
  end

  if frame % 12 == 7 and frame > 349 then
    local pos,x,y
    local index = math.random(1,4)
    if index == 1 then
      pos = 'up'
      x = 0
      y = -300
    elseif index == 3 then
      pos = 'down'
      x = 0
      y = 300
    elseif index == 4 then
      pos = 'right'
      x = -300
      y = 0
    elseif index == 2 then
      pos = 'left'
      x = 300
      y = 0
    end
    local spear = SetDefault('attack/mspearry',x,y)
    spear.sprite.rotation = 90*index + 180
    spear.SetVar('theta',math.pi*index/2+math.pi)
    spear.SetVar('pos',pos)
    spear.SetVar('mv',{x=-x/110,y=-y/110})
    spear.SetVar('color','red')
    spear.SetVar('spin',0)
    spear.SetVar('speed',3)
    table.insert(yspears,spear)
  end

  for i = 1, #spears do
    if spears[i].isactive then
      local mv = spears[i].GetVar('mv')
      spears[i].Move(2*mv.x,2*mv.y)

      if spears[i].x^2 + spears[i].y^2 <= 12 then
        spears[i].Remove()
      end
      soul.green.Parry(spears[i],spears[i].GetVar('color'))
    end
  end


  for i = 1, #yspears do
    if yspears[i].isactive then
      local mv = yspears[i].GetVar('mv')

      if yspears[i].x^2 + yspears[i].y^2 <= 40000 and yspears[i].GetVar('spin') ~= 30/yspears[i].GetVar('speed') then
        local theta = yspears[i].GetVar('theta')+math.pi/30*yspears[i].GetVar('speed')
        local radius = math.sqrt(yspears[i].x^2 + yspears[i].y^2)-math.sqrt((2*mv.x)^2+(2*mv.y)^2)
        yspears[i].MoveTo(radius*math.cos(theta),radius*math.sin(theta))
        yspears[i].SetVar('theta',theta)
        yspears[i].sprite.rotation = yspears[i].sprite.rotation+6*yspears[i].GetVar('speed')
        yspears[i].SetVar('spin',yspears[i].GetVar('spin')+1)
      elseif yspears[i].GetVar('spin') == 0 then
        yspears[i].Move(2*mv.x,2*mv.y)
      else
        yspears[i].Move(-2*mv.x,-2*mv.y)
      end

      if yspears[i].x^2 + yspears[i].y^2 <= 12 then
        yspears[i].Remove()
      end
      soul.green.Parry(yspears[i],yspears[i].GetVar('color'))
    end
  end

  if frame == 750 then
    soul.Change()
    dyne.destroy()
    EndWave()
  end
end

function OnHit(bullet)
  Hit(bullet)
end