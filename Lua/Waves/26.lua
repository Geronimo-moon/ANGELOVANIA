require 'Libraries/bulletType'
require 'Libraries/hsvToRgb'
require 'Libraries/deadForce'

local soul = require 'Libraries/soulManager'
soul.Init({'yellow'})
Arena.Resize(150,150)

local frame = 0

local ubox = {}
local dbox = {}
local lbox = {}
local rbox = {}
local box = {}
local warns = {}
local spears = {}
local slashs = {}
local screen999 = nil
local deathtime = nil
local died = false

local dyne = require 'Animations/backMonster'
dyne.init('monsters/dyne')

function Update()
  frame = frame + 1
  soul.Update()
  dyne.update(frame)

  if frame % 80 == 0 and frame <= 399 then
    for i = 0, 31 do
      if math.floor(i/8) == 0 then
        local box = SetDefault('attack/shootbox',22*i-Arena.width/2,200)
        table.insert(ubox,box)
      elseif math.floor(i/8) == 1 then
          local box = SetDefault('attack/shootbox',22*(i%8)-Arena.width/2,-200)
          table.insert(dbox,box)
      elseif math.floor(i/8) == 2 then
          local box = SetDefault('attack/shootbox',200,22*(i%8)-Arena.height/2)
          table.insert(rbox,box)
      elseif math.floor(i/8) == 3 then
          local box = SetDefault('attack/shootbox',-200,22*(i%8)-Arena.height/2)
          table.insert(lbox,box)
      end
    end
  end

  for i = 1, #ubox do
    if ubox[i].isactive then
      ubox[i].Move(0,-1.5)
      if ubox[i].absy <= 100 then
        ubox[i].Remove()
      end
      soul.yellow.Hit(ubox[i])
    end
  end
  for i = 1, #dbox do
    if dbox[i].isactive then
      dbox[i].Move(0,1.5)
      if dbox[i].absy >= 380 then
        dbox[i].Remove()
      end
      soul.yellow.Hit(dbox[i])
    end
  end
  for i = 1, #rbox do
    if rbox[i].isactive then
      rbox[i].Move(-1.5,0)
      if rbox[i].absx <= 150 then
        rbox[i].Remove()
      end
      soul.yellow.Hit(rbox[i])
    end
  end
  for i = 1, #lbox do
    if lbox[i].isactive then
      lbox[i].Move(1.5,0)
      if lbox[i].absx >= 490 then
        lbox[i].Remove()
      end
      soul.yellow.Hit(lbox[i])
    end
  end

  if frame == 460 then
    soul.Change({'yellow','green'})
    Arena.Resize(90,90)
  end

  if frame >= 460 and frame <= 760 then
    if Player.y ~= 0 then
      Player.MoveTo(0,0)
    end

    if frame % 30 == 9 then
      local bx = SetDefault('attack/shootbox',(-1)^math.random(0,1)*math.random(50,200),(-1)^math.random(0,1)*math.random(50,200))

      local x = bx.x
      local y = bx.y
      local dydx = (y)/(x)
      local dir = (-x)/math.abs(x)
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

      bx.SetVar('theta',theta)
      table.insert(box,bx)
    end

    for i = 1, #box do
      if box[i].isactive then
        local theta = box[i].GetVar('theta')
        box[i].Move(2*math.cos(theta),2*math.sin(theta))
        if box[i].x^2 + box[i].y^2 <= 5 then
          box[i].Remove()
        end
        soul.yellow.Hit(box[i])
      end
    end

    if frame % 20 == 0 then
      local pos,x,y
      local index = math.random(1,4)
      if index == 1 then
        pos = 'up'
        x = 0
        y = 200
      elseif index == 3 then
        pos = 'down'
        x = 0
        y = -200
      elseif index == 4 then
        pos = 'right'
        x = 200
        y = 0
      elseif index == 2 then
        pos = 'left'
        x = -200
        y = 0
      end
      local spear = SetDefault('attack/mspearb',x,y)
      spear.sprite.rotation = 90*index
      spear.SetVar('pos',pos)
      spear.SetVar('mv',{x=-x/100,y=-y/100})
      table.insert(spears,spear)
    end

    for i = 1, #spears do
      if spears[i].isactive then
        local mv = spears[i].GetVar('mv')
        spears[i].Move(3*mv.x,3*mv.y)

        if spears[i].x^2 + spears[i].y^2 <= 5 then
          spears[i].Remove()
        end
        soul.green.Parry(spears[i])
      end
    end
  end

  if frame == 760 then
    soul.Change()
    for i = 1, #spears do
      if spears[i].isactive then
        spears[i].Remove()
      end
    end
    for i = 1, #box do
      if box[i].isactive then
        box[i].Remove()
      end
    end

    local vwarn = SetSprite('slash/emerb',0,0)
    vwarn.SetVar('spawn',frame)
    vwarn.sprite.rotation = 90
    table.insert(warns,vwarn)
    Audio.PlaySound('thunder')
    local bwarn = SetSprite('slash/emerb',0,0)
    bwarn.SetVar('spawn',frame)
    table.insert(warns,bwarn)
    Audio.PlaySound('thunder')
  end

  for i=1,#warns do
    if warns[i].isactive then
      local spawn = warns[i].GetVar('spawn')
      warns[i].sprite.color = hsvToRgb((spawn+30-frame)*2,255,255)

      if spawn + 30 - frame == 0 then
        local slash = SetDieForce('slash/slashb',warns[i].x,warns[i].y)
        slash.sprite.rotation = warns[i].sprite.rotation
        slash.ppcollision = true
        table.insert(slashs,slash)
        warns[i].Remove()
      end
    end
  end

  if not died then
    for i=1,#slashs do
      if slashs[i].isactive then
        slashs[i].sprite.alpha = slashs[i].sprite.alpha - 0.1
        if slashs[i].sprite.alpha == 0.2 then
          slashs[i].SetVar('type','sprite')
        elseif slashs[i].sprite.alpha == 0 then
          slashs[i].Remove()
        end
      end
    end

    if frame == 800 then
      EndWave()
      dyne.destroy()
    end
  else
    KillCount(frame,deathtime,screen999)
  end
end

function OnHit(bullet)
  local die = Hit(bullet)
  -- 即死を食らっている場合999...を生成
  if die and not died then
    died = true
    local list = KillForce(frame)
    screen999 = list[1]
    deathtime = list[2]
  end
end