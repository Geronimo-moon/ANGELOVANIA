require 'Libraries/bulletType'
require 'Libraries/deadForce'
require 'Libraries/hsvToRgb'
require 'Libraries/blaster'
local arenas, handle_movement = require('Libraries/Arena/init')()
local soul = require 'Libraries/soulManager'
soul.Init({'blue'})

local frame = 1780

local screen999 = nil
local deathtime = nil
local died = false

local box = SetSprite("empty", 0,0,"BelowBullet")
box.sprite.Mask("box")

local bonestab = {bones = {},dir = "up",warn = nil,papy = nil, boog = nil,bullet={}}
local longfall = {knives = {},lknives={},rknives={},chaos=nil}
local undyne = {spears = {}, box = {}, alph = nil, dyne = nil}

local px = SetSprite('px',0,0)
px.sprite.color = {0,0,0}
px.sprite.alpha = 0
px.sprite.Scale(Misc.WindowWidth,Misc.WindowHeight)
px.MoveToAbs(Misc.WindowWidth/2,Misc.WindowHeight/2)

function Update()
  handle_movement()
  arenas.update_all_arenas()
  soul.Update()
  frame = frame+1
  if GetGlobal('dt').isactive then
    GetGlobal('dt').alpha = GetGlobal('dt').alpha - 0.05
    if GetGlobal('dt').alpha == 0 then
      GetGlobal('dt').Remove()
    end
  end
  if died then
    KillCount(frame,deathtime,screen999)
  else
    if frame <= 640 then
      BonesTab(frame)
    elseif frame > 640 and frame < 669 then
      Arena.Resize(150,frame*3)
    elseif frame == 669 then
      Arena.Move(0,-100)
      soul.Change()
      Player.sprite.color = {0,0,1}
      Player.sprite.rotation = 180
      Player.Move(100,0)
    elseif frame >= 670 and frame < 1800 then
      if Player.absy > Misc.WindowHeight-10 then
        Player.MoveToAbs(Player.absx,Misc.WindowHeight-10)
      elseif Player.absy < 10 then
        Player.MoveToAbs(Player.absx,10)
      end
      LongFall(frame-670)
    elseif frame == 1800 then
      Audio.Pause()
      Audio.PlaySound('BeginBattle2')
      px.sprite.alpha = 1
      Arena.Resize(90,90,true)
      Arena.MoveTo(Misc.WindowWidth/2,Misc.WindowHeight/3,true,true)
    elseif frame == 1819 then
      Audio.Unpause()
      Audio.PlaySound('BeginBattle2')
      px.sprite.alpha = 0
      Player.MoveTo(0,0)
      soul.Change({'yellow','green'})
    elseif frame >= 1820 and frame <= 2120 then
      Undyne(frame-1820)
    elseif frame == 2121 then
      Audio.Pause()
      Audio.PlaySound('BeginBattle2')
      px.sprite.alpha = 1
      Arena.Resize(180,180,true)
    elseif frame == 2139 then
      Audio.Unpause()
      Audio.PlaySound('BeginBattle2')
      px.sprite.alpha = 0
      soul.Change({'cyan'})
    end
  end
end

function BonesTab(frame)
  if frame==1 then
    bonestab.papy = SetSprite('monsters/papy',150,150)
    bonestab.boog = SetSprite('monsters/boog',-150,100)
    Arena.Resize(150,150)
    box.sprite.Scale(Arena.width/box.sprite.width, Arena.height/box.sprite.height)
  end
  box.MoveTo(0,0)
  if frame%40==1 then
    if bonestab.warn == nil then
      bonestab.warn = SetSprite("warnarea",0,0)
      bonestab.warn.sprite.color = {1,1,0}
    end
    local num = math.random(1,4)
    if num == 1 then
      bonestab.dir = "up"
      if frame >= 320 then
        num = 2
      end
    elseif num == 2 then
      bonestab.dir = "down"
      if frame >= 320 then
        num = 1
      end
    elseif num == 3 then
      bonestab.dir = "right"
      if frame >= 320 then
        num = 4
      end
    elseif num == 4 then
      bonestab.dir = "left"
      if frame >= 320 then
        num = 3
      end
    end
    soul.blue.SetDir(bonestab.dir,true)

    for i = 0, 11 do
      local bone
      if num == 1 then
        bone = SetDefault('attack/bonev',-Arena.width/2+14*i,Arena.height/2+145)
        bone.SetVar('mv',{0,-1})
        bonestab.warn.sprite.Scale(1.50,0.55+math.floor(frame/320)*0.6)
        bonestab.warn.sprite.alpha = 1
        bonestab.warn.MoveTo(0,48-math.floor(frame/320)*30)
      elseif num == 2 then
        bone = SetDefault('attack/bonev',-Arena.width/2+14*i,-Arena.height/2-145)
        bone.SetVar('mv',{0,1})
        bonestab.warn.sprite.Scale(1.50,0.55+math.floor(frame/320)*0.6)
        bonestab.warn.sprite.alpha = 1
        bonestab.warn.MoveTo(0,-48+math.floor(frame/320)*30)
      elseif num == 3 then
        bone = SetDefault('attack/boneb',Arena.width/2+145,-Arena.height/2+14*i)
        bone.SetVar('mv',{-1,0})
        bonestab.warn.sprite.Scale(0.55+math.floor(frame/320)*0.6,1.50)
        bonestab.warn.sprite.alpha = 1
        bonestab.warn.MoveTo(48-math.floor(frame/320)*30,0)
      elseif num == 4 then
        bone = SetDefault('attack/boneb',-Arena.width/2-145,-Arena.height/2+14*i)
        bone.SetVar('mv',{1,0})
        bonestab.warn.sprite.Scale(0.55+math.floor(frame/320)*0.6,1.50)
        bonestab.warn.sprite.alpha = 1
        bonestab.warn.MoveTo(-48+math.floor(frame/320)*30,0)
      end
      bone.sprite.SetParent(box.sprite)
      table.insert(bonestab.bones,bone)
    end

    for i = 0, 5 do
      local bullet = SetDefault('attack/fbullet',Player.x+90*math.cos(math.pi/3*i),Player.y+90*math.sin(math.pi/3*i))
      bullet.SetVar('mv',{-4*math.cos(math.pi/3*i),-4*math.sin(math.pi/3*i)})
      bullet.sprite.Scale(0.5,0.5)
      bullet.sprite.color = {1,0,0}
      bullet.ppcollision = true
      table.insert(bonestab.bullet,bullet)
    end
  end

  for i = 1, #bonestab.bones do
    if bonestab.bones[i].isactive then
      local mv = bonestab.bones[i].GetVar('mv')
      bonestab.bones[i].Move((5+math.floor(frame/320)*2)*mv[1]*3/4,(5+math.floor(frame/320)*2)*mv[2]*3/4)
      if frame%40==0 then
        bonestab.bones[i].Remove()
      end
    end
  end

  for i = 1, #bonestab.bullet do
    if bonestab.bullet[i].isactive then
      local mv = bonestab.bullet[i].GetVar('mv')
      bonestab.bullet[i].Move(mv[1],mv[2])

      if frame%40 == 0 then
        bonestab.bullet[i].Remove()
      end
    end
  end

  if frame%40==9 then
    bonestab.warn.sprite.alpha = 0
  end

  if frame == 319 then
    soul.Change({'blue','orange'})
  end

  if frame == 640 then
    soul.Change({'blue'})
    soul.blue.SetDir('down',true)
    bonestab.papy.Remove()
    bonestab.boog.Remove()
  end
end

function LongFall(frame)
  if frame == 1 then
    box.sprite.Scale(Arena.width/box.sprite.width, Arena.height/box.sprite.height)
  elseif frame < 30 then
    box.MoveTo(0,0)
  elseif frame >= 30 and frame <= 600 then
    if frame % 2 == 0 then
      local lknife = SetNotime('knifel',Arena.width/2.2-22*math.sin(frame/10),0)
      local rknife = SetNotime('knifer',-Arena.width/2.2-22*math.sin(frame/10),0)
      lknife.MoveToAbs(lknife.absx,Misc.WindowHeight)
      rknife.MoveToAbs(rknife.absx,Misc.WindowHeight)
      lknife.sprite.Scale(1.6,1)
      rknife.sprite.Scale(1.6,1)
      lknife.sprite.SetParent(box.sprite)
      rknife.sprite.SetParent(box.sprite)
      lknife.SetVar('spawn',frame)
      rknife.SetVar('spawn',frame)
      lknife.ppcollision = true
      rknife.ppcollision = true
      table.insert(longfall.knives,lknife)
      table.insert(longfall.knives,rknife)
    end
  elseif frame >= 750 and frame < 1000 then
    if frame%26==0 then
      local lknife = SetNotime('knifer',-Arena.width/2+32,0)
      lknife.MoveToAbs(lknife.absx,Misc.WindowHeight)
      lknife.sprite.Scale(0.9,1)
      lknife.sprite.SetParent(box.sprite)
      lknife.ppcollision = true
      table.insert(longfall.lknives,lknife)
    end
    if frame%26==13 then
      local rknife = SetNotime('knifel',Arena.width/2-32,0)
      rknife.MoveToAbs(rknife.absx,Misc.WindowHeight)
      rknife.sprite.Scale(0.9,1)
      rknife.sprite.SetParent(box.sprite)
      rknife.ppcollision = true
      table.insert(longfall.rknives,rknife)
    end
  elseif frame == 1000 then
    Arena.Move(0,-Arena.height*2/3,false,true)
    Arena.Move(0,-350,false)
    soul.Change({'blue'})
    soul.blue.SetDir('up',true)
  elseif frame == 1020 then
    longfall.chaos = SetBlaster('chaos',-180,Player.y-50)
    longfall.chaos.sprite.Scale(1,2.5)
  elseif frame == 1129 and longfall.chaos ~= nil then
    longfall.chaos.GetVar('beam').Remove()
    longfall.chaos.GetVar('center').Remove()
    longfall.chaos.Remove()
    return
  end
  for i = 1, #longfall.knives do
    if longfall.knives[i].isactive then
      local spawn = longfall.knives[i].GetVar('spawn')
      longfall.knives[i].Move(0,0.15*(frame-spawn-80))
      if longfall.knives[i].absy >= Misc.WindowHeight+30 then
        longfall.knives[i].Remove()
      end
    end
  end
  for i = 1, #longfall.lknives do
    if longfall.lknives[i].isactive then
      longfall.lknives[i].Move(0.32,-5)
      longfall.lknives[i].sprite.Scale(longfall.lknives[i].sprite.xscale+0.01,1)
      if longfall.lknives[i].absy <= 0 then
        longfall.lknives[i].Remove()
      end
    end
  end
  for i = 1, #longfall.rknives do
    if longfall.rknives[i].isactive then
      longfall.rknives[i].Move(-0.32,-5)
      longfall.rknives[i].sprite.Scale(longfall.rknives[i].sprite.xscale+0.01,1)
      if longfall.rknives[i].absy <= 0 then
        longfall.rknives[i].Remove()
      end
    end
  end
  if longfall.chaos ~= nil and frame < 1129 then
    UpdateBlaster(longfall.chaos,frame)
    if not longfall.chaos.isactive then
      return
    end
    if Arena.isMoving then
      longfall.chaos.MoveTo(longfall.chaos.x,Player.y)
    end
  end
end

function Undyne(frame)
  if frame == 0 then
    undyne.alph = SetSprite('monsters/alph',-150,150)
    undyne.dyne = SetSprite('monsters/dyne',150,150)
  end
  if frame % 15 == 0 then
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
    spear.SetVar('mv',{x=-x/150,y=-y/150})
    table.insert(undyne.spears,spear)
  end

  for i = 1, #undyne.spears do
    if undyne.spears[i].isactive then
      local mv = undyne.spears[i].GetVar('mv')
      undyne.spears[i].Move(3*mv.x,3*mv.y)

      if undyne.spears[i].x^2 + undyne.spears[i].y^2 <= 5 or frame == 300 then
        undyne.spears[i].Remove()
      end
      soul.green.Parry(undyne.spears[i])
    end
  end

  if frame % 30 == 9 then
    local bx = SetDefault('attack/volt',(-1)^math.random(0,1)*math.random(50,200),(-1)^math.random(0,1)*math.random(50,200))

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
    table.insert(undyne.box,bx)
  end

  for i = 1, #undyne.box do
    if undyne.box[i].isactive then
      local theta = undyne.box[i].GetVar('theta')
      undyne.box[i].Move(1.5*math.cos(theta),1.5*math.sin(theta))
      if undyne.box[i].x^2 + undyne.box[i].y^2 <= 5 or frame == 300 then
        undyne.box[i].Remove()
      end
      soul.yellow.Hit(undyne.box[i])
    end
  end

  if frame == 300 then
    undyne.alph.Remove()
    undyne.dyne.Remove()
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